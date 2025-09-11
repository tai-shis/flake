{ config, pkgs, ... }:

{

  imports = [
    ./languages.nix
  ];

  programs.zsh.shellAliases = {
    emacs = "emacs -nw";
  };

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-nox;

    extraConfig = builtins.readFile ./init.el;

    extraPackages = epkgs: with epkgs; [
      # Add color themes that aren't built-in
      doom-themes
      nord-theme
      doom-modeline
      # ... other packages
    ];
  };
}
