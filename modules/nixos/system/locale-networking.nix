{ pkgs, ... }:

{
  time.timeZone = "America/Edmonton";
  i18n.defaultLocale = "en_CA.UTF-8";

  networking = {
    firewall.enable = true;
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
      "2606:4700:4700::1111"
      "2606:4700:4700::1001"
    ];
    networkmanager = {
      enable = true;
      dns = "none";
      wifi.powersave = false;
      wifi.scanRandMacAddress = false;
    };
  };
}
