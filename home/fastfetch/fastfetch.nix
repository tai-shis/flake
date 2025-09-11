{ configs, pkgs, ... }:

{
  programs.fastfetch = {
    enable = true;

    package = pkgs.fastfetch;

    settings = {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
      logo = {
        source = "nixos-small";
        padding = {
          right = 1;
        };
      };

      display = {
	separator = ": ";
      };

      modules = [
	"break"
	{
	  type = "custom";
	  format = "┌────────────────────── Framework Laptop 13 ─────────────────────┐";
	  outputColor = "#00A86B";
	}
	{
	  type = "host";
	  key = "  PC";
	  keyColor = "#00A86B";
	}
	{
	  type = "cpu";
	  key = "│ ├ CPU";
	  showPeCoreCount = "true";	  
	  keyColor = "#00A86B";
	}
	{
	  type = "display";
	  key = "│ ├󰹑 DISPLAY";
	  keyColor = "#00A86B";
	}
	{
	  type = "memory";
	  key = "│ ├󰍛 MEMORY";
	  keyColor = "#00A86B";
	}
	{
	  type = "disk";
	  key = "│ ├ DISK";
	  keyColor = "#00A86B";
	}
	{
	  type = "battery";
	  key = "│ ├ Battery";
	  keyColor = "#00A86B";
	}

	{
	  type = "custom";
	  format = "└────────────────────────────────────────────────────────────────┘";
	  outputColor = "#00A86B";
        }
	"break"
	{
          type = "custom";
          format = "┌───────────────────────────── NixOS ────────────────────────────┐";
	  outputColor = "blue";
	}
	{
	  type = "os";
	  key = " OS";
	  keyColor = "blue";	
	}
	{
	  type = "title";
	  key = "│ ├ USER/HOST";
	  format = "{user-name}@{host-name}";
	  keyColor = "blue";
	}
	{
	  type = "kernel";
	  key = "│ ├ KERNEL";
	  keyColor = "blue";
	}
	{
	  type = "terminal";
	  key = "│ ├ TERMINAL";
	  keyColor = "blue";
	}
	{
	  type = "terminalfont";
	  key = "│ ├󰛖 TERMINAL FONT";
	  keyColor = "blue";
	}
	{
	  type = "shell";
	  key = "│ ├ SHELL";
	  keyColor = "blue";
	}
	{
          type = "custom";
          format = "└────────────────────────────────────────────────────────────────┘";
	  outputColor = "blue";
	}
      ];
    };
  };
}
