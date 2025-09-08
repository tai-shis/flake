{
  description = "nixOS Fl ake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";    
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { 
    self, 
    nixpkgs,
    home-manager,
    ... 
  }@inputs: {
    nixosConfigurations = {
      truffle = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
   
	specialArgs = { inherit inputs; };

        modules = [
	  ./hosts/truffle/configuration.nix
	  
	  # Can add home-manager things here i think
	  home-manager.nixosModules.home-manager
	  {
      	    home-manager = {
	      useGlobalPkgs = true;
	      useUserPackages = true;
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
