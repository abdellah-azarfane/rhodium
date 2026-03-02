{ pkgs
, ...
}: {
  # TODO: Configure your system-wide user settings (groups, etc), add more users as needed.
  users.users = {
    # FIXME: Replace with your username
    zayron = {
      # TODO: You can set an initial password for your user.
      # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
      # Be sure to change it (using passwd) after rebooting!
      initialPassword = "qwwe";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
      extraGroups = [
        "wheel"
        "networkmanager"
        "docker"
        "input"
        "uinput"
        "video"
      ]; # User groups (determines permissions)
      shell = pkgs.zsh; # Default shell (options: pkgs.bash, pkgs.zsh, pkgs.fish
    };
  };
  # NOTE: Required for devenv
  nix.settings.trusted-users = [
    "root"
    "zayron"
  ];
}
