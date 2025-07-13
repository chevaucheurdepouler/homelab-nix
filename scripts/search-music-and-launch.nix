{ pkgs }:
pkgs.writeShellScriptBin "search-music-and-launch" ''
  	mpc clear
    	mpc add $(mpc listall | ${pkgs.fuzzel}/bin/fuzzel --dmenu)
  	mpc play
''
