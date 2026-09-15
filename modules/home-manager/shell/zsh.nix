{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "af-magic";
      plugins = [
        "direnv"
      ];
    };

    shellAliases = {
      ll = "ls -l";
      ls = "ls -a";
      ".." = "cd ..";
      nixswitch = "nh os switch ~/nix";
      pyenv = "source .venv/bin/activate";
    };

    initContent = ''
      # Ctrl+Backspace deletes the previous word (Ghostty sends ^H for it).
      bindkey '^H' backward-kill-word

      # af-magic's own PS1, with the hostname inserted to the left of the path.
      PS1="''${FG[237]}\''${(l.\$(afmagic_dashes)..-.)}%{$reset_color%}
      ''${FG[035]}%m ''${FG[032]}%~\$(git_prompt_info)\$(hg_prompt_info) ''${FG[105]}%(!.#.»)%{$reset_color%} "

      # Runs fastfetch with a pokeget logo matching the hostname, vertically
      # centering the (shorter) logo against the module list and horizontally
      # centering the whole block in the terminal.
      ff() {
        local logo modLines logoLines padTop output stripped width cols padx

        logo="$(pokeget "$(hostname)" --hide-name --shiny)"
        logoLines=$(print -r -- "$logo" | wc -l)
        modLines=$(fastfetch --logo none | wc -l)

        padTop=$(( (modLines - logoLines) / 2 ))
        (( padTop < 0 )) && padTop=0

        output="$(fastfetch --pipe false --logo-type data-raw --logo-padding-top "$padTop" --logo "$logo")"

        stripped="$(print -r -- "$output" | sed -E 's/\x1b\[[0-9;]*m//g')"
        width=$(print -r -- "$stripped" | awk '{ if (length > m) m = length } END { print m }')
        cols=$(tput cols)
        padx=$(( (cols - width) / 2 ))
        (( padx < 0 )) && padx=0

        print -n '\n\n\n\n'
        print -r -- "$output" | while IFS= read -r line; do
          printf '%*s%s\n' "$padx" "" "$line"
        done
        print -n '\n\n\n\n'
      }

      # Toggles the mruVPN openvpn service: starts it if stopped, stops it if
      # running, and reports the resulting status either way.
      mruvpn() {
        if systemctl is-active --quiet openvpn-mruVPN.service; then
          sudo systemctl stop openvpn-mruVPN.service
          echo "mruVPN stopped"
        else
          sudo systemctl start openvpn-mruVPN.service
          if systemctl is-active --quiet openvpn-mruVPN.service; then
            echo "mruVPN started"
          else
            echo "mruVPN failed to start"
            systemctl status openvpn-mruVPN.service --no-pager
          fi
        fi
      }

      if [[ -o interactive ]]; then
        ff
      fi
    '';
  };

  home.sessionVariables.SHELL = "${pkgs.zsh}/bin/zsh";
}
