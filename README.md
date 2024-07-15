# my nix homelab config

**THIS CONFIG IS STILL EXPERIMENTAL !! IT MIGHT WONT WORK OR JUST BREAK YOUR CURRENT INSTALL**
Hosted on a Proxmox VM (8Gb RAM + 300Gb storage). It is not using the flake.nix because i don't see the use for it, as much than home-manager...

The goal of this config is to include :

- -arr suite
- Authentik
- slskd
- a cloud solution, to backup family files
- crafty controller
- a matrix server
- tt-rss
- tailscale

## Installation

You will need to do a basic NixOS install with my config files placed @ `/etc/nixos`.
Then, setup and adapt the config with your secrets. I am using sops-nix here.
