{ inputs, ... }:
{
  nixpkgs.overlays = [
    inputs.rust-overlay.overlays.default
    inputs.nur.overlay

    # TODO : overlay pour firefox-base16-native
  ];
}
