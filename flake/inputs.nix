{
  nixpkgs = {
    url = "github:NixOS/nixpkgs/nixos-25.11";
  };

  nixpkgs-unstable = {
    url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  home-manager = {
    url = "github:nix-community/home-manager/release-25.11";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake-parts = {
    url = "github:hercules-ci/flake-parts";
  };

  sops-nix = {
    url = "github:Mic92/sops-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  nur = {
    url = "github:nix-community/NUR";
  };

  zen-browser = {
    url = "github:0xc000022070/zen-browser-flake";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  kanso-nvim = {
    url = "github:pabloagn/kanso.nvim"; # NOTE: Personal fork
    flake = false;
  };

  chiaroscuro = {
    url = "github:pabloagn/chiaroscuro.rht";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  rhodium-alloys = {
    url = "github:pabloagn/alloys.rhf";
    # inputs.nixpkgs.follows = "nixpkgs";
  };

  disko = {
    url = "github:nix-community/disko";
    inputs.nixpkgs.follows = "nixpkgs";
  };
}
