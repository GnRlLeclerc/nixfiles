# Additional python packages missing from nixpkgs
final: prev: {
  packageOverrides = finalPy: prevPy: {

    # lpips package (with overridable opencv4 dependency because I need it)
    lpips = final.python312.pkgs.callPackage (
      { buildPythonPackage, opencv4, ... }:
      buildPythonPackage rec {
        pname = "lpips";
        version = "0.1.4";

        src = final.python312.pkgs.fetchPypi {
          inherit pname version;
          sha256 = "sha256-OEYzHfbGloiuw9MApe7vbFKUNbyEYL1YIBw9YuVhiPo=";
        };

        dependencies = with final.python312.pkgs; [
          torch
          torchvision
          numpy
          opencv4
          scikit-image
          matplotlib
          tqdm
          ipykernel
        ];
      }
    ) { };
  };
}
