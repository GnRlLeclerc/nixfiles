# Overlays for the stable and unstable nixpkgs
{ inputs, ... }:
{
  stable = [
    inputs.rust-overlay.overlays.default
    inputs.nur.overlays.default

  ] ++ (import ./stable);
  unstable = [
    inputs.rust-overlay.overlays.default
    inputs.nur.overlays.default

  ] ++ (import ./unstable);
}
