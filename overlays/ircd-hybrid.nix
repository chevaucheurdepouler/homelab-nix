{config, ...}: {

  nixpkgs.overlays = [
    (self: super: {
      ircdHybrid
    })
  ];

}
