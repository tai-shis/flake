{ pkgs, inputs, ... }:

let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in
{
  # Declarative spicetify via spicetify-nix, instead of running spicetify-cli
  # against pkgs.spotify directly: the raw CLI patches Spotify's installed
  # files in place, which fails against the read-only Nix store path
  # pkgs.spotify lives in ("Cannot detect Spotify location"). This module
  # builds a pre-patched Spotify derivation at eval time instead, so it
  # doesn't need spotify_path set and survives Spotify version bumps cleanly.
  imports = [ inputs.spicetify-nix.homeManagerModules.spicetify ];

  programs.spicetify = {
    enable = true;
    # The "text" TUI theme, maintained upstream in spicetify/spicetify-themes
    # (unlike the AvinashReddy3108/spicetify-tui original it's based on,
    # which is unmaintained since 2023 and breaks against current Spotify).
    theme = spicePkgs.themes.text;
    colorScheme = "Kanagawa";

    wayland = true;
  };
}
