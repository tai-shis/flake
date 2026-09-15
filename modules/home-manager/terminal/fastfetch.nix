{ pkgs, ... }:

let
  # fastfetch's format strings can't pad the concatenated result of several
  # placeholders (only a single variable at a time), which leaves stray gaps in
  # composite rows like disk/memory. Building with Lua scripting support lets
  # those rows compute their full string first and pad it as one unit.
  #
  # nixpkgs' fastfetch-unwrapped doesn't build with Lua: CMake's find_package(Lua)
  # picks up an unsupported Lua 5.2 pulled in transitively via enlightenment.efl's
  # "elua" bindings (rpm's own lua dep also has to go, or it wins the same race).
  # Neither rpm nor Enlightenment support is used on this system, so dropping both
  # is free. fastfetch also dlopens liblua at runtime under a versioned name
  # ("liblua5.4.so") that nixpkgs' lua5_4 package doesn't produce (it ships
  # "liblua.so"/"liblua.so.5.4"), so a small symlink shim provides that name.
  fastfetchUnwrappedLua = pkgs.fastfetch-unwrapped.overrideAttrs (old: {
    buildInputs = (pkgs.lib.filter (p: p != pkgs.rpm && p != pkgs.enlightenment.efl) old.buildInputs) ++ [ pkgs.lua5_4 ];
  });
  luaCompat = pkgs.runCommand "liblua-compat" { } ''
    mkdir -p $out/lib
    ln -s ${pkgs.lua5_4}/lib/liblua.so $out/lib/liblua5.4.so
  '';
  fastfetchLua = pkgs.fastfetch.override {
    fastfetch-unwrapped = fastfetchUnwrappedLua;
    extraRuntimeDependencies = [ luaCompat ];
  };
in
{
  programs.fastfetch = {
    enable = true;

    package = fastfetchLua;

    settings = {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
      logo = {
        source = "nixos-small";
        padding = {
          right = 1;
        };
      };

      display = {
        separator = " ";
      };

      modules = [
        "break"
        {
          type = "custom";
          format = "{#35}┏━━━━━━━━━━━━┓ ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓";
        }
        {
          type = "title";
          key = "{#35}┃ {##50fa7b}󰀄 {##bd93f9}host     {#35}┃";
          format = "{#35}┃ {##8be9fd}{2<36} {#35}┃";
        }
        {
          type = "os";
          key = "{#35}┃ {##50fa7b}󰟾 {##bd93f9}distro   {#35}┃";
          format = "{#35}┃ {##8be9fd}{3<36} {#35}┃";
        }
        {
          type = "kernel";
          key = "{#35}┃ {##50fa7b} {##bd93f9}kernel   {#35}┃";
          format = "{#35}┃ {##8be9fd}{1} {2<30} {#35}┃";
        }
        {
          type = "uptime";
          key = "{#35}┃ {##50fa7b} {##bd93f9}uptime   {#35}┃";
          format = "{#35}┃ {##8be9fd}{formatted<36} {#35}┃";
        }
        {
          type = "de";
          key = "{#35}┃ {##50fa7b}󰇄 {##bd93f9}desktop  {#35}┃";
          format = "{#35}┃ {##8be9fd}{pretty-name<36} {#35}┃";
        }
        {
          type = "terminal";
          key = "{#35}┃ {##50fa7b} {##bd93f9}terminal {#35}┃";
          format = "{#35}┃ {##8be9fd}{pretty-name<36} {#35}┃";
        }
        {
          type = "shell";
          key = "{#35}┃ {##50fa7b} {##bd93f9}shell    {#35}┃";
          format = "{#35}┃ {##8be9fd}{6<36} {#35}┃";
        }
        {
          type = "disk";
          key = "{#35}┃ {##50fa7b}󰋊 {##bd93f9}disk     {#35}┃";
          format = "lua:local a = ...; local s = a.sizeUsed .. ' / ' .. a.sizeTotal .. ' (' .. a.sizePercentage .. ')'; local vis = s:gsub('\\27%[[%d;]*m', ''); local vislen = #vis; if vislen > 36 then s = vis:sub(1,36); vislen = 36 end; local padded = s .. string.rep(' ', 36 - vislen); return '\\27[35m┃ \\27[38;2;139;233;253m' .. padded .. ' \\27[35m┃\\27[0m'";
        }
        {
          type = "memory";
          key = "{#35}┃ {##50fa7b} {##bd93f9}memory   {#35}┃";
          format = "lua:local a = ...; local s = a.used .. ' / ' .. a.total .. ' (' .. a.percentage .. ')'; local vis = s:gsub('\\27%[[%d;]*m', ''); local vislen = #vis; if vislen > 36 then s = vis:sub(1,36); vislen = 36 end; local padded = s .. string.rep(' ', 36 - vislen); return '\\27[35m┃ \\27[38;2;139;233;253m' .. padded .. ' \\27[35m┃\\27[0m'";
        }
        {
          type = "custom";
          format = "{#35}┗━━━━━━━━━━━━┛ ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛";
        }
      ];
    };
  };

  home.packages = [ pkgs.pokeget-rs ];
}
