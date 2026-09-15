{ pkgs, username, fullName, ... }:

{
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  users.users.${username} = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = fullName;
    extraGroups = [ "networkmanager" "wheel" "video" ];
  };
}
