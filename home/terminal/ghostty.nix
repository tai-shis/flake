{ configs, pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    settings = {
      font-size = 12;
      font-family = "MesloGS Nerd Font";

      window-width = 90;
      window-height = 24;      

      window-padding-x = 12;
      window-padding-y = 12;
      window-padding-balance = true;

      shell-integration = "zsh";

      window-decoration = "auto";

      window-inherit-working-directory = true;
      theme = "Dracula";
    };
  };
}
