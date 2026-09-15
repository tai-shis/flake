{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    openvpn3
  ];

  services.openvpn.servers = {
    mruVPN = {
      config = ''config /home/booky/.config/openvpn/macovpn-config.ovpn'';
      autoStart = false;
    };
  };
}
