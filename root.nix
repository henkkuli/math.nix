math:
let
  # Newton iteration for square root
  iter =
    a: x:
    let
      err = (x * x - a) / (2 * x);
    in
    if math.feq 0 err then x else iter a (x - err);
  sqrt = math.ffun (
    x:
    assert x >= 0;
    if x < 1.0e-300 then 0.0 else iter x (1 * x)
  );

  cbrt = x: math.exp (math.ln x / 3);

  pow = b: e: math.exp (math.ln b * e);

in
# sqrt
assert math.feq (sqrt 0) 0;
assert math.feq (sqrt 1.0e-10) 1.0e-5;
assert math.feq (sqrt 1.0e-2) 0.1;
assert math.feq (sqrt 1) 1;
assert math.feq (sqrt 2) 1.4142135623730951;
assert math.feq (sqrt 4) 2;
assert math.feq (sqrt 10) 3.1622776601683795;
assert math.feq (sqrt 1.0e40) 1.0e20;
# cbrt
assert math.feq (cbrt 1) 1;
assert math.feq (cbrt 2) 1.2599210498948734;
assert math.feq (cbrt 8) 2;
assert math.feq (cbrt 10) 2.1544346900318834;
# assert math.feq (cbrt 1.0e60) 1.0e20;
{
  inherit sqrt cbrt pow;
}
