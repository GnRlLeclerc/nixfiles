{
  inputs,
  ...
}:
{
  nixpkgs.overlays = [
    inputs.rust-overlay.overlays.default
    inputs.nur.overlay

    # Custom native messaging host for Firefox theming
    (final: prev: {
      firefox-native-base16 = final.rustPlatform.buildRustPackage {
        pname = "firefox-native-base16";
        version = "0.1.0";

        src = prev.fetchFromGitHub {
          owner = "GnRlLeclerc";
          repo = "firefox-native-base16";
          rev = "master";
          sha256 = "sha256-fpUcf9G/iSqG9a9yKlsPuOUTqzpj8g+VgrUkjituBUI=";
        };

        cargoHash = "sha256-dUGu4hUy72chewE6Hgh6JCfT9AWyJHY9q6nPnOsdNr0=";

        meta = {
          description = "A simple native application to dynamically change your browser theme using base16.";
          homepage = "https://github.com/GnRlLeclerc/firefox-native-base16";
          license = final.lib.licenses.mit;
          maintainers = [ ];
        };
      };
    })
  ];
}
