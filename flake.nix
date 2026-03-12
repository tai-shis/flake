{
  description = "nixOS Fl ake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";    
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vicinae = {
      url = "github:vicinaehq/vicinae";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      type = "github";
      owner = "niri-wm";
      repo = "niri";
      ref = "wip/branch";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.noctalia-qs.follows = "noctalia-qs";
    };

    noctalia-qs = {
      url = "github:noctalia-dev/noctalia-qs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    awww = {
      url = "git+https://codeberg.org/LGFae/awww";
      inputs.nixpkgs.follows = "nixpkgs";      
    };
  };

  outputs = { 
    nixpkgs,
    ... 
  }@inputs: {
    nixosConfigurations = {
      truffle = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        
	      specialArgs = {
          inherit inputs;
          system = "x86_64-linux";
        };

        modules = [

	        ./hosts/truffle/configuration.nix

          # Can add home-manager things here i think
          inputs.home-manager.nixosModules.home-manager
	        {
            home-manager = {
	            useGlobalPkgs = true;
	            useUserPackages = true;
              backupFileExtension = "backup";              
	            extraSpecialArgs = { inherit inputs; };
	            users.booky = import ./home/home.nix;
	          };
	        }
	      ];
      };
    };
    # Can also add formatter (alejandra)
  };
}
