{ config, pkgs, lib, ... }: {
  programs.fish = {
    enable = true;
  };

  xdg.configFile.fish = {
    source = ../config/fish;
    recursive = true;
  };
}

