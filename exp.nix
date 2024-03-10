math:
let
  # Exponential function
  exp_iter =
    i: x: px:
    if px != 0 then px + (exp_iter (i + 1) x (px * x / i)) else 0;
  exp = math.ffun (x: exp_iter 1 x 1);
  expm1 = math.ffun (x: exp_iter 2 x x);
  # Natural logarithm
  ln2 = 0.6931471805599453;
  # ln_neg =
  #   x:
  #   if x;
  # ln_pos =
  #   x:
  #   assert x > 2;
  #   x;
  # Halley iteration for ln(1 + x)
  ln_iter =
    a: x:
    let
      err = (exp x - a) / (exp x + a);
    in
    # res = exp (1 + x) + a;
    if math.feq 0 err then x else ln_iter a (x - 2 * err);

  ln = math.ffun (
    x:
    if x < 0.5 then
      ln (2 * x) - ln2
    else if x > 2 then
      ln (0.5 * x) + ln2
    else
      ln_iter x 0
  );
  # TODO: Proper version of this
  lnp1 = math.ffun (x: ln (1 + x));
in
# exp
assert math.feq (exp 0) 1;
assert math.feq (exp 1) 2.71828182846;
assert math.feq (exp 2) 7.38905609893;
# expm1
assert math.feq (expm1 1.0e-5) 1.0000050000166668e-5;
assert math.feq (expm1 2) 6.38905609893;
# ln
assert math.feq (ln 1) 0;
assert math.feq (ln (exp 1)) 1;
assert math.feq (ln (exp 10)) 10;
# assert math.feq (ln (exp (-10))) (-10);
assert math.feq (exp (ln 1)) 1;
# assert math.feq (exp (ln 10)) 10;
{
  inherit
    exp
    expm1
    ln
    lnp1
    ;
}
