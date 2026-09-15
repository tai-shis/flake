{ pkgs, config, ... }:

{
  services.fprintd = {
    enable = true;
    tod.driver = pkgs.libfprint-2-tod1-goodix;
  };

  # fprintd is D-Bus-activated by default, which delays the USB reset/init
  # of the sensor until the first login attempt, racing the greeter's
  # fingerprint prompt. Starting it at boot isn't enough on its own: fprintd
  # exits after being idle for a while, so by the time the greeter appears
  # it has often already shut back down. -t/--no-timeout disables that idle
  # exit so the warm daemon actually survives until first login.
  systemd.services.fprintd = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig.ExecStart = [
      ""
      "${config.services.fprintd.package}/libexec/fprintd --no-timeout"
    ];
  };
}
