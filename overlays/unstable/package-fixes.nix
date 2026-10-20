# Package fixes for the unstable nixpkgs
[
  (final: prev: {
    # TODO: remove once fixed upstream (https://hydra.nixos.org/build/349913027)
    udiskie = prev.udiskie.overridePythonAttrs (oldAttrs: {
      disabledTests = (oldAttrs.disabledTests or [ ]) ++ [ "test_invalidate" ];
    });
  })
]
