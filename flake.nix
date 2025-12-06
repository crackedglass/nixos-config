{
  description = "NixOs configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs@{ self, nixpkgs, nixos-hardware, home-manager, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      modules = [ 
      	./configuration.nix 
       	nixos-hardware.nixosModules.lenovo-thinkpad-x1-6th-gen 
       	home-manager.nixosModules.home-manager {
       	  home-manager = {
       	    useGlobalPkgs = true;
       	    useUserPackages = true;
       	    users.ilya = import ./home.nix;
       	    backupFileExtension = "backup";
       	  };
       	}
     ];
    };
  };
}

