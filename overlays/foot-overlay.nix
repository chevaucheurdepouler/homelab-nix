{ config, lib, pkgs, ... }:
{
  let foot-next = pkgs.foot.overrideAttrs (oldAttrs: rec {
    inherit (oldAttrs) name;
    version = "1.20.2";
    src = pkgs.fetchFromGitea {
    domain = "codeberg.org";
    owner = "dnkl";
    repo = "foot";
    rev = version;
    hash = "sha256-tnBoRRKHcuvBSnqvJ/772UWuepvpUiSg6t+gx4MZ0VQ=";
    };
  }) in
  nixpkgs.overlays = [(
    final: previous: {
      foot = foot-next;
    }
  )];
}