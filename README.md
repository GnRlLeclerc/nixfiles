# Nixfiles

<div align="center">
<img src="./nixos.png" alt="NixOS logo" height="300">
</div>

My NixOS dotfiles and current config.

## First install

```bash
git clone https://github.com/GnRlLeclerc/dotfiles ~/nixfiles
cd ~/nixfiles
sudo nixos-rebuild switch --flake .#main-laptop –extra-experimental-features nix-command –extra-experimental-features flakes
```

## Shortcuts

Switch:

```bash
just switch
```

Test:

```bash
just test
```

Update nixpkgs:

```bash
just update-nixpkgs
```

Prune old configurations (remember to switch after in order to update the boot menu):

```bash
just prune
```

## Non NixOS systems

Switch:

```bash
just thibaut
```
