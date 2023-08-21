{ config, pkgs, lib, ... }: {
  programs.neovim = {
    enable = true;
  };
  xdg.configFile.nvim = {
    source = ../config/nvim;
    recursive = true;
  };
}
