{
  hostName,
  system ? "x86_64-linux",
  modules ? [ ],
  specialArgs ? { },
}:
{ inputs, outputs, ... }:
inputs.nixpkgs.lib.nixosSystem {
  inherit system;
  specialArgs = {
    inherit inputs outputs;
  } // specialArgs;
  modules = [
    # Common modules for all hosts
    inputs.home-manager.nixosModules.home-manager
    inputs.disko.nixosModules.disko
    inputs.stylix.nixosModules.stylix
    # Base configuration
    {
      networking.hostName = hostName;
    }
  ] ++ modules;
}

