{
  description = "Mathematic functions implemented in Nix";

  outputs =
    { self }:
    {
      pi = 3.141592653589793;

      inherit (import ./helpers.nix self) fmod ffun feq;
      inherit (import ./sincos.nix self) sin cos atan atan2;
      inherit (import ./root.nix self) sqrt cbrt pow;
      inherit (import ./exp.nix self) exp expm1 ln lnp1;
    };
}
