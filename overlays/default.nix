# Overlays for the stable and unstable nixpkgs
{ inputs, ... }:
{
  stable = [
    inputs.rust-overlay.overlays.default
    inputs.nur.overlay

  ] ++ (import ./stable);
  unstable = [
    inputs.rust-overlay.overlays.default
    inputs.nur.overlay

  ] ++ (import ./unstable);
}
