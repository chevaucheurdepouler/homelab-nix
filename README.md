# my nix homelab config

**THIS CONFIG IS STILL EXPERIMENTAL !! IT MIGHT WONT WORK OR JUST BREAK YOUR CURRENT INSTALL**
Hosted on a Proxmox VM (8Go RAM + 300Gb storage). It is not using the flake.nix because i don't see the use for it, as much than home-manager...

The goal of this config is to include :

- [x] -arr suite
- [x] Authentik
- [x] slskd
- [ ] a cloud solution, to backup family files
- [x] crafty controller\*
- [x] a matrix server
- [x] tt-rss / freshrss\*
- [x] tailscale

\*Not using the "Nix" way (i prefer using Docker atm, i currently lack time)

## Installation

You will need to do a basic NixOS install with my config files placed @ `/etc/nixos`.
Then, setup and adapt the config with your secrets. I am using sops-nix here.
