{ config, pkgs, lib, ... }: {
  programs.emacs = {
    enable = true;
    package = pkgs.emacs29-pgtk;
  };

  programs.emacs.extraPackages = epkgs: [
    epkgs.exec-path-from-shell
    epkgs.base16-theme
    epkgs.vterm
#    epkgs.uniquify
    epkgs.undo-tree
    epkgs.meow
    epkgs.orderless
    epkgs.marginalia
    epkgs.corfu
    epkgs.which-key
    epkgs.vertico
#    epkgs.tramp
    epkgs.project
    epkgs.paredit
    epkgs.rainbow-delimiters
    epkgs.slime
    epkgs.clojure-mode
    epkgs.clojure-mode-extra-font-locking
    epkgs.clj-refactor
    epkgs.cider
    epkgs.flycheck
    epkgs.eglot
#    epkgs.tree-sitter
    epkgs.tree-sitter-langs
    epkgs.rustic
    epkgs.apheleia
    epkgs.typescript-mode
    epkgs.go-mode
    epkgs.zig-mode
    epkgs.org
  ];

  services.emacs.enable = true;

  xdg.configFile."emacs" = {
    source = ../config/emacs.d;
    recursive = true;
  };
}

