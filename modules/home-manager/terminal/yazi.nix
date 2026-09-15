{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;

    # Dracula theme, to match ghostty. Vendored from yazi-rs/flavors (the
    # official flavor repo); includes tmtheme.xml for preview syntax highlighting.
    flavors.dracula = ./dracula.yazi;
    theme.flavor = {
      dark = "dracula";
      light = "dracula";
    };
  };
}
