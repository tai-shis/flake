{inputs, ...}: {
  imports = [
    inputs.vicinae.homeManagerModules.default
  ];

  services.vicinae = {
    enable = true;
    systemd= {
      enable = true;
      autoStart = true;
      environment = {
        USE_LAYER_SHELL = 1;
      };
    };

    settings = {
      close_on_focus_loss = true;
      pop_to_root_on_close = true;

      theme = {
        light = {
          name = "dracula";
          icon_theme = "default";
        };
        dark = {
          name = "dracula";
          icon_theme = "default";
        };
      };
    };
  };
}
  
