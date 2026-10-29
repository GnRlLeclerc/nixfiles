# Package fixes for the unstable nixpkgs
[
  (final: prev: {
    # TODO: remove once fixed upstream (https://hydra.nixos.org/build/349913027)
    udiskie = prev.udiskie.overridePythonAttrs (oldAttrs: {
      disabledTests = (oldAttrs.disabledTests or [ ]) ++ [ "test_invalidate" ];
    });

    # TODO: remove once the nixpkgs-built electron works again (https://github.com/NixOS/nixpkgs/issues/578970)
    # Obsidian opens an empty window with the source-built electron 43.8.3, the upstream binary works
    obsidian = prev.obsidian.override { electron = final.electron_43-bin; };
  })
]
