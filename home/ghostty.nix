{ configs, pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    settings = {
      font-size = 12;
      font-family = "MesloGS Nerd Font";
      window-padding-x = 12;
      window-padding-y = 12;
      window-padding-balance = true;
      shell-integration = "zsh";
    };
  };
}
