# nix dotfiles

This repo hosts all my dotfiles. It includes two desktop config, one (terrible) computer config, and some server dots. It brings my own neovim config, called [miovim](https://git.rougebordeaux.xyz/misschloe/miovim).

| name        | description                                       |
| ----------- | ------------------------------------------------- |
| `goober`    | my main desktop config. Intel 9th gen + 1660 GPU. Packs up games, VM and programming stuff |
| `workspace` | my config for professional workspaces.            |
| `sisyphe`   | proxmox server vm                                 |
| `labouse`   | ASUS X75s (laptop) nix config. Highly experimental, as this is old hardware!  |
| `dadarwin`   | some basic iMac 2015 config.  |

`diva`, `strawberry` are WIP. Supposed to be two servers config.

- `diva` should be the replacement to my Debian VM who's running Bluesky PDS, and my global reverse proxy i'm running
- `strawberry` is a config for a NAS i'm planning to build.

`packages` also comes with some packages bundling i made for various software i use (and too shy to put in nixpkgs).

# Installation
!! This config is not plug and play; it comes with some encrypted secrets and files that are not included here. !!

Make sure flakes and nix command is enabled first in your configuration, then run : 

```bash
git clone <repo-url>
# replace goober by whatever config interests you
sudo nixos-rebuild switch --flake .#goober
```

# TODO

- [ ] Do a proper backup strategy on my server VMs
- [ ] Set a proper log monitoring service
- [ ] make the home manager config properly standalone, for the non nix machines. allows to have a quick environment tailored to my preferences wherever i am
