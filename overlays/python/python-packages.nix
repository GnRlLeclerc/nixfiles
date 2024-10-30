# Additional python packages missing from nixpkgs
final: prev: {
  packageOverrides = finalPy: prevPy: {

    lpips = final.python312.pkgs.callPackage (
      {
        torch,
        torchvision,
        opencv4,
        numpy,
        scikit-image,
        matplotlib,
        tqdm,
        ipykernel,
        ...
      }:
      final.python312.pkgs.buildPythonPackage rec {
        pname = "lpips";
        version = "0.1.4";

        src = final.python312.pkgs.fetchPypi {
          inherit pname version;
          sha256 = "sha256-OEYzHfbGloiuw9MApe7vbFKUNbyEYL1YIBw9YuVhiPo=";
        };

        dependencies = [
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
