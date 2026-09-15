{ pkgs, ... }:

{
  boot.loader.systemd-boot.enable = false;

  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    theme = pkgs.stdenvNoCC.mkDerivation {
      pname = "astronaut-grub-theme";
      version = "a39546d";
      src = pkgs.fetchFromGitHub {
        owner = "Flava-Clown";
        repo = "AstronautGrub";
        rev = "a39546d72fe8ecab3411b27a42c9951542ade531";
        sha256 = "0sx2lw29c6szvp91fhsvzia379rrg8wj74y699n02vfgapzkflrs";
      };
      installPhase = ''
        mkdir -p $out
        cp -r astronaut_orange/* $out/
      '';
    };
    # extraEntries = ''
    #   menuentry "Windows" --class windows --class os {
    #     insmod part_gpt
    #     insmod fat
    #     search --fs-uuid --set=root <WINDOWS-EFI-PARTITION-UUID>
    #     chainloader /EFI/Microsoft/Boot/bootmgfw.efi
    #   }
    # '';
  };

  boot.loader.efi.canTouchEfiVariables = true;
}
