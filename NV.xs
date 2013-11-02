
#ifdef  __MINGW32__
#ifndef __USE_MINGW_ANSI_STDIO
#define __USE_MINGW_ANSI_STDIO 1
#endif
#endif


#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"


#include <stdlib.h>
#include <float.h>

#ifdef _MSC_VER
#ifndef strtold
#define strtold strtod
#endif
#endif

SV * nv(char * str) {
   char *ptr;
#ifdef NV_IS_LONG_DOUBLE
   return newSVnv(strtold(str, &ptr));
#else
   return newSVnv(strtod (str, &ptr));
#endif
}

SV * nv_type(void) {
#ifdef NV_IS_LONG_DOUBLE
   return newSVpv("long double", 0);
#else
   return newSVpv("double", 0);
#endif
}

SV * mant_dig(void) {
#ifdef NV_IS_LONG_DOUBLE
   return newSVuv(LDBL_MANT_DIG);
#else
   return newSVuv(DBL_MANT_DIG);
#endif
}

int Isnan_ld (long double d) {
  if(d == d) return 0;
  return 1;
}

/********************************************************
   Code for _ld2binary and _ld_str2binary plagiarised from
   tests/tset_ld.c in the mpfr library source.
********************************************************/

void _ld2binary (SV * ld, long flag) {

  dXSARGS;
  long double d = SvNV(ld);
  long double e;
  int exp = 1;
  unsigned long int prec = 0;
  int returns = 0;

  sp = mark;

  if(Isnan_ld(d)) {
      XPUSHs(sv_2mortal(newSVpv("@NaN@", 0)));
      XPUSHs(sv_2mortal(newSViv(exp)));
      XPUSHs(sv_2mortal(newSViv(prec)));
      XSRETURN(3);
  }

  if (d < (long double) 0.0 || (d == (long double) 0.0 && (1.0 / (double) d < 0.0))) {
      XPUSHs(sv_2mortal(newSVpv("-", 0)));
      returns++;
      d = -d;
  }

  /* now d >= 0 */
  /* Use 2 differents tests for Inf, to avoid potential bugs
     in implementations. */
  if (Isnan_ld (d - d) || (d > 1 && d * 0.5 == d)) {
      XPUSHs(sv_2mortal(newSVpv("@Inf@", 0)));
      XPUSHs(sv_2mortal(newSViv(exp)));
      XPUSHs(sv_2mortal(newSViv(prec)));
      returns += 3;
      XSRETURN(returns);
  }

  if (d == (long double) 0.0) {
      XPUSHs(sv_2mortal(newSVpv("0.0", 0)));
      XPUSHs(sv_2mortal(newSViv(exp)));
      XPUSHs(sv_2mortal(newSViv(prec)));
      returns += 3;
      XSRETURN(returns);
  }

  /* now d > 0 */
  e = (long double) 1.0;
  while (e > d) {
      e = e * (long double) 0.5;
      exp --;
  }

  if(flag) printf ("1: e=%.36Le\n", e);

  /* now d >= e */
  while (d >= e + e) {
      e = e + e;
      exp ++;
  }

  if (flag) printf ("2: e=%.36Le\n", e);

  /* now e <= d < 2e */
  XPUSHs(sv_2mortal(newSVpv("0.", 0)));
  returns ++;
  
  if (flag) printf ("3: d=%.36Le e=%.36Le prec=%lu\n", d, e, prec);
  while (d > (long double) 0.0) {
      prec++;
      if(d >= e) {
        XPUSHs(sv_2mortal(newSVpv("1", 0)));
        returns ++;
        d = (long double) ((long double) d - (long double) e);
      }
      else {
        XPUSHs(sv_2mortal(newSVpv("0", 0)));
        returns ++;
      }
      e *= (long double) 0.5;
      if (flag) printf ("4: d=%.36Le e=%.36Le prec=%lu\n", d, e, prec);
  }

  XPUSHs(sv_2mortal(newSViv(exp)));
  XPUSHs(sv_2mortal(newSViv(prec)));
  returns += 2;
  XSRETURN(returns);
}

void _ld_str2binary (char * ld, long flag) {

  dXSARGS;
  long double d;
  char *ptr;
  long double e;
  int exp = 1;
  unsigned long int prec = 0;
  int returns = 0;

  d = strtold(ld, &ptr);

  sp = mark;

  if(Isnan_ld(d)) {
      XPUSHs(sv_2mortal(newSVpv("@NaN@", 0)));
      XPUSHs(sv_2mortal(newSViv(exp)));
      XPUSHs(sv_2mortal(newSViv(prec)));
      XSRETURN(3);
  }

  if (d < (long double) 0.0 || (d == (long double) 0.0 && (1.0 / (double) d < 0.0))) {
      XPUSHs(sv_2mortal(newSVpv("-", 0)));
      returns++;
      d = -d;
  }

  /* now d >= 0 */
  /* Use 2 differents tests for Inf, to avoid potential bugs
     in implementations. */
  if (Isnan_ld (d - d) || (d > 1 && d * 0.5 == d)) {
      XPUSHs(sv_2mortal(newSVpv("@Inf@", 0)));
      XPUSHs(sv_2mortal(newSViv(exp)));
      XPUSHs(sv_2mortal(newSViv(prec)));
      returns += 3;
      XSRETURN(returns);
  }

  if (d == (long double) 0.0) {
      XPUSHs(sv_2mortal(newSVpv("0.0", 0)));
      XPUSHs(sv_2mortal(newSViv(exp)));
      XPUSHs(sv_2mortal(newSViv(prec)));
      returns += 3;
      XSRETURN(returns);
  }

  /* now d > 0 */
  e = (long double) 1.0;
  while (e > d) {
      e = e * (long double) 0.5;
      exp --;
  }

  if(flag) printf ("1: e=%.36Le\n", e);

  /* now d >= e */
  while (d >= e + e) {
      e = e + e;
      exp ++;
  }

  if (flag) printf ("2: e=%.36Le\n", e);

  /* now e <= d < 2e */
  XPUSHs(sv_2mortal(newSVpv("0.", 0)));
  returns ++;
  
  if (flag) printf ("3: d=%.36Le e=%.36Le prec=%lu\n", d, e, prec);
  while (d > (long double) 0.0) {
      prec++;
      if(d >= e) {
        XPUSHs(sv_2mortal(newSVpv("1", 0)));
        returns ++;
        d = (long double) ((long double) d - (long double) e);
      }
      else {
        XPUSHs(sv_2mortal(newSVpv("0", 0)));
        returns ++;
      }
      e *= (long double) 0.5;
      if (flag) printf ("4: d=%.36Le e=%.36Le prec=%lu\n", d, e, prec);
  }

  XPUSHs(sv_2mortal(newSViv(exp)));
  XPUSHs(sv_2mortal(newSViv(prec)));
  returns += 2;
  XSRETURN(returns);
}



MODULE = Math::NV	PACKAGE = Math::NV	

PROTOTYPES: DISABLE


SV *
nv (str)
	char *	str

SV *
nv_type ()
		

SV *
mant_dig ()
		

void
_ld2binary (ld, flag)
	SV *	ld
	long	flag
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	_ld2binary(ld, flag);
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

void
_ld_str2binary (ld, flag)
	char *	ld
	long	flag
	PREINIT:
	I32* temp;
	PPCODE:
	temp = PL_markstack_ptr++;
	_ld_str2binary(ld, flag);
	if (PL_markstack_ptr != temp) {
          /* truly void, because dXSARGS not invoked */
	  PL_markstack_ptr = temp;
	  XSRETURN_EMPTY; /* return empty stack */
        }
        /* must have used dXSARGS; list context implied */
	return; /* assume stack size is correct */

