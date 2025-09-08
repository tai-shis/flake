{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "tai-shis";
    userEmail = "tshis070@mtroyal.ca";
  };
}
