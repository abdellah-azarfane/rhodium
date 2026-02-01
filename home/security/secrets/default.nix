{ config, inputs, ... }:
{
  imports = [ inputs.sops-nix.homeManagerModules.sops ];

  sops = {
    defaultSopsFile = ./secrets.yaml;

    # We use the variable here so it works for any user!
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";

    secrets.github_key = {
      # %h is a special shortcut sops-nix understands for "Home Directory"
      path = "%h/.ssh/id_ed25519";
    };
  };

  programs.ssh = {
    enable = true;
    matchBlocks."github.com" = {
      # Again, using the path variable from the secret we just defined
      identityFile = [ config.sops.secrets.github_key.path ];
    };
  };
}
