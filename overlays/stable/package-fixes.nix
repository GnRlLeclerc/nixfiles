# Package fixes for the stable nixpkgs
[
  (final: prev: {
    hatch = prev.hatch.overrideAttrs (oldAttrs: {
      disabledTests = oldAttrs.disabledTests ++ [ "test_metadata" ];
    });

    my-test-pkg-for-unstable = prev.hello;
  })
]
