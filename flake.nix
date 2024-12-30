{
  description = "NixOS configuration";
  
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-24.11";
    };  
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };    
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };    
  };
  
  outputs = { self, nixpkgs, disko, nixos-hardware, home-manager }: {
    vagrant = nixpkgs.lib.nixosSystem {
      modules = [
        disko.nixosModules.disko
        ./configuration.nix
        home-manager.nixosModules.home-manager
        ./users/vagrant.nix
        ./hosts/vagrant
      ];
    };
  };
}