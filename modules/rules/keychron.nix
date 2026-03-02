{
  pkgs,
  lib,
  config,
  userName ? null,
  ...
}:

with lib;

{
  options.extraRules.keychronUdev.enable = mkEnableOption "Keychron V1 user‑service trigger";

  config = mkIf config.extraRules.keychronUdev.enable {
    # Prefer the flake/host-provided username, otherwise fall back to the first normal user.
    users.users.${
      if userName != null then userName
      else
        let
          normalUsers = filterAttrs (_: u: (u.isNormalUser or false)) config.users.users;
        in
        if normalUsers == { } then throw "extraRules.keychronUdev.enable requires a normal user (set host userName)"
        else builtins.head (builtins.attrNames normalUsers)
    }.linger = true;

    # NOTE:
    # For this to work, the following needs to be run:
    #   sudo loginctl enable-linger {username}
    # Where {username} = user name
    services.udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="input", KERNEL=="event*", \
        ATTRS{idVendor}=="3434", ATTRS{idProduct}=="0311", \
        TAG+="systemd", \
        ENV{SYSTEMD_USER_WANTS}+="kmonad-keychron.service"
    '';
  };
}
