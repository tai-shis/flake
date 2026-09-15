{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.brightnessctl ];

  # /sys/class/backlight is group-owned "video" by udev; brightnessctl needs
  # the calling user in that group to write without root.
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chgrp video /sys/class/backlight/%k/brightness", RUN+="${pkgs.coreutils}/bin/chmod g+w /sys/class/backlight/%k/brightness"
  '';
}
