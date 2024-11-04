# Devshell for tauri applications development
{ pkgs, ... }:
{
  tauri = pkgs.mkShell {

    buildInputs = with pkgs; [
      openssl
    ];
    shellHook = ''
      export OPENSSL_DIR=${pkgs.openssl.dev}
    '';
  };
}
