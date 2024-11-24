# Additional python packages missing from nixpkgs
final: prev: {
  packageOverrides = finalPy: prevPy: {

    # lpips package (with overridable opencv4 dependency because I need it)
    lpips = final.python312.pkgs.callPackage (
      { buildPythonPackage, opencv4, ... }:
      buildPythonPackage rec {
        pname = "lpips";
        version = "0.1.4";

        src = final.pkgs.fetchFromGitHub {
          owner = "richzhang";
          repo = "PerceptualSimilarity";
          rev = version;
          sha256 = "sha256-dIQ9B/HV/2kUnXLXNxAZKHmv/Xv37kl2n6+8IfwIALE=";
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
