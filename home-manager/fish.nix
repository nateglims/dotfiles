{ config, pkgs, lib, ... }: {
  xdg.configFile.fish = {
    source = ../config/fish;
    recursive = true;
  };
}

