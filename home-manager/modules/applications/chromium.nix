# Chromium configuration
{ ... }:
{
  programs.chromium = {
    extensions = [
      { id = "ddkjiahejlhfcafbddmgiahcphecmpfh"; } # Ublock lite
      { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # Dark Reader
      { id = "nngceckbapebfimnlniiiahkandclblb"; } # Bitwarden
    ];
  };
}
