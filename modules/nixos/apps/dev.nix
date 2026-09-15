{ inputs, system, pkgs, ... }:

let
  # R packages to bake into R and RStudio. Add Rcmdr plugins (RcmdrPlugin.*)
  # or other CRAN packages here rather than via install.packages().
  rDeps = with pkgs.rPackages; [
    Rcmdr    # school/stats/lab1: library(Rcmdr)
    readxl   # school/stats/lab1: read_excel() for SBPbyRace.xlsx
    rgl      # Rcmdr 3D scatterplots (scatter3d); needs GL libs wired in by Nix
  ];
in
{
  environment.systemPackages = [
    inputs.llm-agents.packages.${system}.claude-code
    pkgs.nh
    pkgs.git
    pkgs.pnpm
    (pkgs.rWrapper.override { packages = rDeps; })
    (pkgs.rstudioWrapper.override { packages = rDeps; })
  ];
}
