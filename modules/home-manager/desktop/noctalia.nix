{ inputs, ... }:

{
  imports = [ inputs.noctalia.homeModules.default ];

  programs.noctalia = {
    enable = true;

    # niri's spawn-at-startup already launches it.
    systemd.enable = false;
  };
}
