# Temporary python package fixes
final: prev: {
  packageOverrides = finalPy: prevPy: {

    # Temporary fix for python312Packages.triton-bin
    # Follow this issue https://github.com/NixOS/nixpkgs/issues/351717
    triton-bin = prevPy.triton-bin.overridePythonAttrs (oldAttrs: {
      # problème : il a besoin du prev !
      # exporter packageOverrides à la place ?
      postFixup = ''
        chmod +x "$out/${prev.python312.sitePackages}/triton/backends/nvidia/bin/ptxas"
        substituteInPlace $out/${prev.python312.sitePackages}/triton/backends/nvidia/driver.py \
          --replace \
            'return [libdevice_dir, *libcuda_dirs()]' \
            'return [libdevice_dir, "${prev.addDriverRunpath.driverLink}/lib", "${prev.cudaPackages.cuda_cudart}/lib/stubs/"]'
      '';
    });

    # Temporary fix for python312Packages.proxy-py (hash mismatch)
    # BUG: hydra build seems to succeed?
    proxy-py = prevPy.proxy-py.overridePythonAttrs (oldAttrs: {
      src = prev.pkgs.fetchFromGitHub {
        owner = "abhinavsingh";
        repo = "proxy.py";
        rev = "refs/tags/v${oldAttrs.version}";
        hash = "sha256-icFYpuPF76imPxsRcbqvC03pHdGga2GUwvKqbeWg3+E=";
      };
    });

    # Permanent fix for python312Packages.cfn-lint (ignore some other tests that fail)
    # A new version should come soon (1.18.1), which may fix the issue
    cfn-lint = prevPy.cfn-lint.overridePythonAttrs (oldAttrs: {
      disabledTests = oldAttrs.disabledTests ++ [
        "test_quickstart_templates"
        "test_quickstart_templates_non_strict"
        "test_quickstart_templates_non_strict"
      ];
    });
  };
}
