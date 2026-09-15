{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nil
    rust-analyzer
    haskell-language-server
    clang-tools # clangd + clang-format
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

      # Language modes
      nix-mode
      rust-mode
      haskell-mode

      # LSP support
      lsp-mode
      lsp-ui
      lsp-haskell

      # Completion
      company

      direnv

      flycheck
      treemacs
      magit
    ];
  };
}
