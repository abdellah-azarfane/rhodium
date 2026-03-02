{
  description = "Irix Flake";

  inputs = {
    adios-bot.url = "git+https://git.notthebe.ee/notthebee/adiosbot";
    adios-bot.inputs.nixpkgs.follows = "nixpkgs";
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    ags.url = "github:Aylur/ags";
    ags.inputs.nixpkgs.follows = "nixpkgs";
    astal.url = "github:Aylur/astal";
    astal.inputs.nixpkgs.follows = "nixpkgs";
    alga.url = "github:Tenzer/alga";
    alga.inputs.nixpkgs.follows = "nixpkgs";
    autoaspm.url = "git+https://git.notthebe.ee/notthebee/AutoASPM";
    autoaspm.inputs.nixpkgs.follows = "nixpkgs";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";

    fenix.url = "github:nix-community/fenix";
    fenix.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    invoiceplane.url = "git+https://git.notthebe.ee/notthebee/invoiceplane-nixos";
    invoiceplane.inputs.nixpkgs.follows = "nixpkgs";
    jovian.url = "github:Jovian-Experiments/Jovian-NixOS";
    jovian.inputs.nixpkgs.follows = "nixpkgs";
    nixCats.url = "github:BirdeeHub/nixCats-nvim";
    nix-index-database.url = "github:Mic92/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/nur";
    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
    #secrets = {
    # url = "git+ssh://forgejo@git.n//nix-private.git";
    # flake = false;
    # };
  };

  outputs =
    inputs@{ self
    , flake-parts
    , nixpkgs
    , home-manager
    , stylix
    , ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      imports = [
        ./flake-parts.nix
      ];
      _module.args.rootPath = ./.;
    };
}
