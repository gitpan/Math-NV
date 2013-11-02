use strict;
use warnings;
use Math::NV qw(:all);

eval {require Math::MPFR; Math::MPFR->import(":mpfr")};

if($@) {
  print "1..1\n";
  warn "\nSkipping all tests - couldn't load Math::MPFR:\n$@";
  print "ok 1\n";
  exit 0;
}

if(mant_dig() == 106) {
  print "1..1\n";
  warn "\nSkipping all tests - not applicable to 106-bit mantissa\n";
  print "ok 1\n";
  exit 0;
}

my $compat1 = Math::MPFR::_has_longdouble() ? 1 : 0;
my $compat2 = nv_type() eq "long double"    ? 1 : 0;

##############################################
##############################################

if(!$compat1 && $compat1 == $compat2) {
  print "1..14\n";
  Rmpfr_set_default_prec(mant_dig());
  my $max_dig = int(mant_dig() / 4) + 2;

  my $str = '1e-298';

  if(nv($str) == Rmpfr_get_NV(Math::MPFR->new($str), 0)) {print "ok 1\n"}
  else {
    warn "\n1: nv($str):\n", float_bin(nv($str)),
         "\nRmpfr_get_NV:\n", float_bin(Rmpfr_get_NV(Math::MPFR->new($str), 0)), "\n";
    print "not ok 1\n";
  }

  if(nv($str) == Rmpfr_get_d(Math::MPFR->new($str), 0)) {print "ok 2\n"}
  else {
    warn "\n2: nv($str):\n", float_bin(nv($str)),
         "\nRmpfr_get_d:\n", float_bin(Rmpfr_get_d(Math::MPFR->new($str), 0)), "\n";
    print "not ok 2\n";
  }
#
  $str = '69659e-292';

    if(nv($str) == Rmpfr_get_NV(Math::MPFR->new($str), 0)) {print "ok 3\n"}
  else {
    warn "\n3: nv($str):\n", float_bin(nv($str)),
         "\nRmpfr_get_NV:\n", float_bin(Rmpfr_get_NV(Math::MPFR->new($str), 0)), "\n";
    print "not ok 3\n";
  }

  if(nv($str) == Rmpfr_get_d(Math::MPFR->new($str), 0)) {print "ok 4\n"}
  else {
    warn "\n4: nv($str):\n", float_bin(nv($str)),
         "\nRmpfr_get_d:\n", float_bin(Rmpfr_get_d(Math::MPFR->new($str), 0)), "\n";
    print "not ok 4\n";
  }
#
#
  $str = '80811924651145035e-20';

    if(nv($str) == Rmpfr_get_NV(Math::MPFR->new($str), 0)) {print "ok 5\n"}
  else {
    warn "\n5: nv($str):\n", float_bin(nv($str)),
         "\nRmpfr_get_NV:\n", float_bin(Rmpfr_get_NV(Math::MPFR->new($str), 0)), "\n";
    print "not ok 5\n";
  }

  if(nv($str) == Rmpfr_get_d(Math::MPFR->new($str), 0)) {print "ok 6\n"}
  else {
    warn "\n6: nv($str):\n", float_bin(nv($str)),
         "\nRmpfr_get_d:\n", float_bin(Rmpfr_get_d(Math::MPFR->new($str), 0)), "\n";
    print "not ok 6\n";
  }
#
#
  $str = '26039550862e-20';

    if(nv($str) == Rmpfr_get_NV(Math::MPFR->new($str), 0)) {print "ok 7\n"}
  else {
    warn "\n7: nv($str):\n", float_bin(nv($str)),
         "\nRmpfr_get_NV:\n", float_bin(Rmpfr_get_NV(Math::MPFR->new($str), 0)), "\n";
    print "not ok 7\n";
  }

  if(nv($str) == Rmpfr_get_d(Math::MPFR->new($str), 0)) {print "ok 8\n"}
  else {
    warn "\n8: nv($str):\n", float_bin(nv($str)),
         "\nRmpfr_get_d:\n", float_bin(Rmpfr_get_d(Math::MPFR->new($str), 0)), "\n";
    print "not ok 8\n";
  }
#
#
  $str = '918e-295';

    if(nv($str) == Rmpfr_get_NV(Math::MPFR->new($str), 0)) {print "ok 9\n"}
  else {
    warn "\n9: nv($str):\n", float_bin(nv($str)),
         "\nRmpfr_get_NV:\n", float_bin(Rmpfr_get_NV(Math::MPFR->new($str), 0)), "\n";
    print "not ok 9\n";
  }

  if(nv($str) == Rmpfr_get_d(Math::MPFR->new($str), 0)) {print "ok 10\n"}
  else {
    warn "\n10: nv($str):\n", float_bin(nv($str)),
         "\nRmpfr_get_d:\n", float_bin(Rmpfr_get_d(Math::MPFR->new($str), 0)), "\n";
    print "not ok 10\n";
  }
#
#
  $str = '91563373e-300';

    if(nv($str) == Rmpfr_get_NV(Math::MPFR->new($str), 0)) {print "ok 11\n"}
  else {
    warn "\n11: nv($str):\n", float_bin(nv($str)),
         "\nRmpfr_get_NV:\n", float_bin(Rmpfr_get_NV(Math::MPFR->new($str), 0)), "\n";
    print "not ok 11\n";
  }

  if(nv($str) == Rmpfr_get_d(Math::MPFR->new($str), 0)) {print "ok 12\n"}
  else {
    warn "\n12: nv($str):\n", float_bin(nv($str)),
         "\nRmpfr_get_d:\n", float_bin(Rmpfr_get_d(Math::MPFR->new($str), 0)), "\n";
    print "not ok 12\n";
  }
#
  my($t, $count, $ok) = (0,0,1);
  for my $exp(10, 20, 30, 280 .. 300) {
    for my $digits(1..$max_dig) {
      $t++;
      my $str = random_select($digits) . 'e' . "-$exp";
      if(float_bin(nv($str)) ne float_bin(Rmpfr_get_NV(Math::MPFR->new($str), 0))) {
        if($count < 5) {
          warn "\$str: $str\n";
          warn "nv($str):\n", float_bin(nv($str)), "\nRmpfr_get_NV:\n", float_bin(Rmpfr_get_NV(Math::MPFR->new($str), 0)), "\n\n";
        }
        if($count == 5) { warn "and more ...\n" }
        $count++;
        $ok = 0;
      }
    }
  }

  warn "\n Checked nv() with $t random(ish) values against Rmpfr_get_NV()\n Found $count discrepancies.\n";
  if($ok) {print "ok 13\n"}
  else {print "not ok 13\n"}

  ($t, $count, $ok) = (0,0,1);
  for my $exp(10, 20, 30, 280 .. 300) {
    for my $digits(1..$max_dig) {
      $t++;
      my $str = random_select($digits) . 'e' . "-$exp";
      if(float_bin(nv($str)) ne float_bin(Rmpfr_get_d(Math::MPFR->new($str), 0))) {
        if($count < 5) {
          warn "\$str: $str\n";
          warn "nv($str):\n", float_bin(nv($str)), "\nRmpfr_get_d:\n", float_bin(Rmpfr_get_d(Math::MPFR->new($str), 0)), "\n\n";
        }
        if($count == 5) { warn "and more ...\n" }
        $count++;
        $ok = 0;
      }
    }
  }

  warn "\n Checked nv() with $t random(ish) values against Rmpfr_get_d()\n Found $count discrepancies.\n";
  if($ok) {print "ok 14\n"}
  else {print "not ok 14\n"}
}

##############################################
##############################################

elsif($compat1 && $compat1 == $compat2) {
  print "1..14\n";
  Rmpfr_set_default_prec(mant_dig());
  my $max_dig = int(mant_dig() / 4) + 2;

  my $str = '1e-298';

  if(nv($str) == Rmpfr_get_NV(Math::MPFR->new($str), 0)) {print "ok 1\n"}
  else {
    warn "\n1: nv($str):\n", float_bin(nv($str)),
         "\nRmpfr_get_NV:\n", float_bin(Rmpfr_get_NV(Math::MPFR->new($str), 0)), "\n";
    print "not ok 1\n";
  }

  if(nv($str) == Rmpfr_get_ld(Math::MPFR->new($str), 0)) {print "ok 2\n"}
  else {
    warn "\n2: nv($str):\n", float_bin(nv($str)),
         "\nRmpfr_get_ld:\n", float_bin(Rmpfr_get_ld(Math::MPFR->new($str), 0)), "\n";
    print "not ok 2\n";
  }
#
  $str = '69659e-292';

    if(nv($str) == Rmpfr_get_NV(Math::MPFR->new($str), 0)) {print "ok 3\n"}
  else {
    warn "\n3: nv($str):\n", float_bin(nv($str)),
         "\nRmpfr_get_NV:\n", float_bin(Rmpfr_get_NV(Math::MPFR->new($str), 0)), "\n";
    print "not ok 3\n";
  }

  if(nv($str) == Rmpfr_get_ld(Math::MPFR->new($str), 0)) {print "ok 4\n"}
  else {
    warn "\n4: nv($str):\n", float_bin(nv($str)),
         "\nRmpfr_get_ld:\n", float_bin(Rmpfr_get_ld(Math::MPFR->new($str), 0)), "\n";
    print "not ok 4\n";
  }
#
#
  $str = '80811924651145035e-20';

    if(nv($str) == Rmpfr_get_NV(Math::MPFR->new($str), 0)) {print "ok 5\n"}
  else {
    warn "\n5: nv($str):\n", float_bin(nv($str)),
         "\nRmpfr_get_NV:\n", float_bin(Rmpfr_get_NV(Math::MPFR->new($str), 0)), "\n";
    print "not ok 5\n";
  }

  if(nv($str) == Rmpfr_get_ld(Math::MPFR->new($str), 0)) {print "ok 6\n"}
  else {
    warn "\n6: nv($str):\n", float_bin(nv($str)),
         "\nRmpfr_get_ld:\n", float_bin(Rmpfr_get_ld(Math::MPFR->new($str), 0)), "\n";
    print "not ok 6\n";
  }
#
#
  $str = '26039550862e-20';

    if(nv($str) == Rmpfr_get_NV(Math::MPFR->new($str), 0)) {print "ok 7\n"}
  else {
    warn "\n7: nv($str):\n", float_bin(nv($str)),
         "\nRmpfr_get_NV:\n", float_bin(Rmpfr_get_NV(Math::MPFR->new($str), 0)), "\n";
    print "not ok 7\n";
  }

  if(nv($str) == Rmpfr_get_ld(Math::MPFR->new($str), 0)) {print "ok 8\n"}
  else {
    warn "\n8: nv($str):\n", float_bin(nv($str)),
         "\nRmpfr_get_ld:\n", float_bin(Rmpfr_get_ld(Math::MPFR->new($str), 0)), "\n";
    print "not ok 8\n";
  }
#
#
  $str = '918e-295';

    if(nv($str) == Rmpfr_get_NV(Math::MPFR->new($str), 0)) {print "ok 9\n"}
  else {
    warn "\n9: nv($str):\n", float_bin(nv($str)),
         "\nRmpfr_get_NV:\n", float_bin(Rmpfr_get_NV(Math::MPFR->new($str), 0)), "\n";
    print "not ok 9\n";
  }

  if(nv($str) == Rmpfr_get_ld(Math::MPFR->new($str), 0)) {print "ok 10\n"}
  else {
    warn "\n10: nv($str):\n", float_bin(nv($str)),
         "\nRmpfr_get_ld:\n", float_bin(Rmpfr_get_ld(Math::MPFR->new($str), 0)), "\n";
    print "not ok 10\n";
  }
#
#
  $str = '91563373e-300';

    if(nv($str) == Rmpfr_get_NV(Math::MPFR->new($str), 0)) {print "ok 11\n"}
  else {
    warn "\n11: nv($str):\n", float_bin(nv($str)),
         "\nRmpfr_get_NV:\n", float_bin(Rmpfr_get_NV(Math::MPFR->new($str), 0)), "\n";
    print "not ok 11\n";
  }

  if(nv($str) == Rmpfr_get_ld(Math::MPFR->new($str), 0)) {print "ok 12\n"}
  else {
    warn "\n12: nv($str):\n", float_bin(nv($str)),
         "\nRmpfr_get_ld:\n", float_bin(Rmpfr_get_ld(Math::MPFR->new($str), 0)), "\n";
    print "not ok 12\n";
  }
#
  my($t, $count, $ok) = (0,0,1);
  for my $exp(10, 20, 30, 280 .. 300) {
    for my $digits(1..$max_dig) {
      $t++;
      my $str = random_select($digits) . 'e' . "-$exp";
      if(float_bin(nv($str)) ne float_bin(Rmpfr_get_NV(Math::MPFR->new($str), 0))) {
        if($count < 5) {
          warn "\$str: $str\n";
          warn "nv($str):\n", float_bin(nv($str)), "\nRmpfr_get_NV:\n", float_bin(Rmpfr_get_NV(Math::MPFR->new($str), 0)), "\n\n";
        }
        if($count == 5) { warn "and more ...\n" }
        $count++;
        $ok = 0;
      }
    }
  }

  warn "\n Checked nv() with $t random(ish) values against Rmpfr_get_NV()\n Found $count discrepancies.\n";
  if($ok) {print "ok 13\n"}
  else {print "not ok 13\n"}

  ($t, $count, $ok) = (0,0,1);
  for my $exp(10, 20, 30, 280 .. 300) {
    for my $digits(1..$max_dig) {
      $t++;
      my $str = random_select($digits) . 'e' . "-$exp";
      if(float_bin(nv($str)) ne float_bin(Rmpfr_get_ld(Math::MPFR->new($str), 0))) {
        if($count < 5) {
          warn "\$str: $str\n";
          warn "nv($str):\n", float_bin(nv($str)), "\nRmpfr_get_ld:\n", float_bin(Rmpfr_get_ld(Math::MPFR->new($str), 0)), "\n\n";
        }
        if($count == 5) { warn "and more ...\n" }
        $count++;
        $ok = 0;
      }
    }
  }

  warn "\n Checked nv() with $t random(ish) values against Rmpfr_get_ld()\n Found $count discrepancies.\n";
  if($ok) {print "ok 14\n"}
  else {print "not ok 14\n"}
}

##############################################
##############################################

else {
  print "1..1\n";
  warn "Skipping all tests - can't reconcile the build of Math::MPFR with your NV type\n";
  print "ok 1\n";
}

##############################################
##############################################

sub float_bin {
  my @in = ld2binary($_[0], 0);
  return $in[0] . 'e' . $in[1];
}

sub str_bin {
  my @in = ld_str2binary($_[0], 0);
  return $in[0] . 'e' . $in[1];
}

sub random_select {
  my $ret = '';
  for(1 .. $_[0]) {
    $ret .= int(rand(10));
  }
  return $ret;
}

# m32-ld
# 80811924651145035e-20 
# 26039550862e-20

# m64-ld
# 918e-295
# 91563373e-300
