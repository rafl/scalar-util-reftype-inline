#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "callchecker0.h"

static SV *hintkey_sv_reftype;

static OP *
pp_reftype (pTHX)
{
  dVAR; dSP; dTARGET;
  const char *pv;
  SV * const sv = POPs;

  if (sv)
	SvGETMAGIC(sv);

  if (!sv || !SvROK(sv))
	RETPUSHNO;

  pv = sv_reftype(SvRV(sv),FALSE);
  PUSHp(pv, strlen(pv));
  RETURN;
}

static OP *
ck_reftype (pTHX_ OP *op, GV *namegv, SV *o)
{
  OP *args;
  args = cUNOPx(ck_entersub_args_list(op))->op_first;
  if(!args->op_sibling) args = cUNOPx(args)->op_first;
  op_free(args->op_sibling->op_sibling);
  args->op_sibling->op_sibling = NULL;
  op = newUNOP(OP_NULL, 0, args->op_sibling);
  args->op_sibling = NULL;
  op_free(args);
  op->op_type = OP_RAND;
  op->op_ppaddr = pp_reftype;
  return op;
}

MODULE = Scalar::Util::reftype::Inline  PACKAGE = Scalar::Util::reftype::Inline

BOOT:
  hintkey_sv_reftype = newSVpvs_share("Scalar::Util::reftype::Inline/reftype");
  cv_set_call_checker(GvCV(gv_fetchmethod(gv_stashpvs("Scalar::Util::reftype::Inline", 0),
                                          "reftype")),
                      ck_reftype, &PL_sv_undef);
