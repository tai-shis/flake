{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "tai-shis";
        email = "tshis070@mtroyal.ca";
      };
    };
  };
}
