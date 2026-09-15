{ pkgs, ... }:

{
  imports = [
    ./emacs.nix
  ];

  # Baseline C toolchain for scratch work / command-line compiling.
  # Project-specific toolchains and libraries belong in a per-project flake devshell.
  home.packages = with pkgs; [
    gcc
    gnumake
    gdb
  ];
}
