math:
let
  iter =
    i: x: px:
    if px > 0 then px - (iter (i + 2) x (px * x * x / (i + 1) / (i + 2))) else 0;
  sin = math.ffun (
    x:
    let
      # Make sure that x is in appropriate range
      y = math.fmod (2 * math.pi) x;
    in
    iter 1 y y
  );
  cos = math.ffun (
    x:
    let
      # Make sure that x is in appropriate range
      y = math.fmod (2 * math.pi) x;
    in
    iter 0 y 1
  );

  # https://stackoverflow.com/a/23097989
  atan = math.ffun (
    x:
    if x < 0 then
      # Make x positive
      -atan (-x)
    else if x > 1 then
      # Make x to be in range [0, 1
      (0.5 * math.pi) - (atan (1 / x))
    else
      let
        # Not real fma, but can later be replaced with a proper implementation
        fma =
          a: b: c:
          a * b + c;

        s = x * x;
        q = s * s;
        p1 = -2.0258553044340116e-5;
        t1 = 2.2302240345710764e-4;
        p2 = fma p1 q (-1.164071777991222e-3);
        t2 = fma t1 q 3.8559749383656407e-3;
        p3 = fma p2 q (-9.18455921872222e-3);
        t3 = fma t2 q 1.697803583459466e-2;
        p4 = fma p3 q (-2.5826796814492296e-2);
        t4 = fma t3 q 3.406781108271581e-2;
        p5 = fma p4 q (-4.092638242051e-2);
        t5 = fma t4 q 4.6739496199158334e-2;
        p6 = fma p5 q (-5.2392330054601366e-2);
        t6 = fma t5 q 5.877307772179068e-2;
        p7 = fma p6 q (-6.665860363351289e-2);
        t7 = fma t6 q 7.692212930586789e-2;
        p8 = fma p7 s t7;
        p9 = fma p8 s (-9.090901235400527e-2);
        p10 = fma p9 s 0.11111110678749421;
        p11 = fma p10 s (-0.1428571427133481);
        p12 = fma p11 s 0.19999999999755005;
        p13 = fma p12 s (-0.3333333333333184);
        p14 = fma (p13 * s) x x;
      in
      p14
  );

  atan2 = math.ffun (
    y: x:
    if y >= 0 && x >= 0 then
      # First quadrant
      if y > x then (0.5 * math.pi) - (atan (x / y)) else atan (y / x)
    else if y >= 0 then
      # Second quadrant
      math.pi - atan2 y (-x)
    else
      # Lower half plane
      -atan2 (-y) x
  );
in
# sin
assert math.feq (sin 0) 0;
assert math.feq (sin (0.5 * math.pi)) 1;
assert math.feq (sin math.pi) 0;
assert math.feq (sin (1.5 * math.pi)) (-1);
assert math.feq (sin (-0.5 * math.pi)) (-1);
# cos
assert math.feq (cos 0) 1;
assert math.feq (cos (0.5 * math.pi)) 0;
assert math.feq (cos math.pi) (-1);
assert math.feq (cos (1.5 * math.pi)) 0;
assert math.feq (cos (-0.5 * math.pi)) 0;
{
  inherit
    sin
    cos
    atan
    atan2
    ;
}
