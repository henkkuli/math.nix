math:
let
  # Compute a % b
  fmod =
    b: a:
    if a >= 0 then
      if a < b then a else fmod b (a - b * (builtins.floor (a / b)))
    else
      fmod b (b - fmod b (-a));
  # Ensure that the argument to a single-argument function is float
  ffun = f: x: f (1.0 * x);
  # Ensure that the arguments to a two-argument function is float
  ffun2 =
    f: x: y:
    f (1.0 * x) (1.0 * y);
  # Compare two floating-point numbers with a small epsilon
  eps = 1.0e-10;
  feq = ffun2 (a: b: if a < b then b - a < eps else a - b < eps);
in
# fmod
assert fmod 10 17 == 7;
assert fmod 10 (-3) == 7;
# TODO: Check that the function doesn't overflow stack
assert fmod 1.0 1.0e10 == 0.0;
# assert fmod 1.0 1.0e100 == 0.0;
# assert fmod 1.0 1.0e200 == 0.0;
# ffun
assert builtins.isFloat (ffun (x: x) 1);
# feq
assert feq 1 1;
assert !feq 1 2;
assert feq 1 (1 + 1.0e-11);
{
  inherit fmod ffun feq;
}
