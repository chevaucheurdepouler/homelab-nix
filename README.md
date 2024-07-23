# my nix homelab config

**THIS CONFIG IS STILL EXPERIMENTAL !! IT MIGHT WONT WORK OR JUST BREAK YOUR CURRENT INSTALL**
Hosted on a Proxmox VM (8Go RAM + 300Gb storage). It is not using the flake.nix because i don't see the use for it, as much than home-manager...

The goal of this config is to include :

- [x] -arr suite
- [x] Authentik
- [x] slskd
- [ ] a cloud solution, to backup family files
- [x] crafty controller\*
- [ ] a matrix server
- [x] tt-rss / freshrss\*
- [ ] tailscale

\*Not using the "Nix" way (i prefer using Docker atm, i currently lack time)

# TODO

- [x] fix homepage-dashboard secrets
- [ ] use Docker for Sonarr, seems to be a cleaner approach for double instances
- [ ] move crafty-controller to a nix build
- [ ] figure out how to use secrets with freshrss

## Installation

You will need to do a basic NixOS install with my config files placed @ `/etc/nixos`.
Then, setup and adapt the config with your secrets. I am using sops-nix here.
