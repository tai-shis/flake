{ pkgs, ... }:

{
  home.packages = [ pkgs.nerd-fonts.meslo-lg ];

  programs.ghostty = {
    enable = true;
    settings = {
      font-size = 12;
      font-family = "MesloGS Nerd Font";

      window-width = 132;
      window-height = 46;

      window-padding-x = 12;
      window-padding-y = 12;
      window-padding-balance = true;

      shell-integration = "zsh";
      # Auto-install the xterm-ghostty terminfo entry on remote hosts over
      # SSH so tools like emacs -nw don't fail with "Terminal type
      # xterm-ghostty is not defined."; falls back to xterm-256color if
      # installation isn't possible.
      shell-integration-features = "ssh-env,ssh-terminfo";

      window-decoration = "auto";

      window-inherit-working-directory = true;
      theme = "Dracula";
    };
  };
}
