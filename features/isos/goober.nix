{
  pkgs,
  modulesPath,
  lib,
  ...
}:
{
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"

    # Provide an initial copy of the NixOS channel so that the user
    # doesn't need to run "nix-channel --update" first.
    "${modulesPath}/installer/cd-dvd/channel.nix"
  ];

  # use the latest Linux kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Needed for https://github.com/NixOS/nixpkgs/issues/58959
  boot.supportedFilesystems = lib.mkForce [
    "btrfs"
    "reiserfs"
    "vfat"
    "f2fs"
    "xfs"
    "ntfs"
    "cifs"
  ];

  boot.blacklistedKernelModules = [
    "b43"
    "b43legacy"
    "ssb"
    "bcma"
    "bcm43xx"
    "brcm80211"
    "brcmfmac"
    "brcmsmac"
    "bcma"
  ];

  boot.extraModprobeConfig = ''
    options cfg80211 cfg80211_disable_40mhz_24ghz=Y
  '';

  environment.systemPackages = with pkgs; [
    # Add your own packages here
    broadcom_sta
    neovim

  ];
}
