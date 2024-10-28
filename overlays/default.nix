{
  inputs,
  ...
}:
{
  nixpkgs.overlays = [
    inputs.rust-overlay.overlays.default
    inputs.nur.overlay

    (import ./triton-fix.nix)
  ];
}
