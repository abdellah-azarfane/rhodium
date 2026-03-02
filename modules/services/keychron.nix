{ config
, pkgs
, lib
, ...
}:

{
  systemd.services.kmonad-keychron = {
    description = "KMonad for Keychron keyboard";

    # Start once multi‑user is up
    after = [ "multi-user.target" ];
    wantedBy = [ "multi-user.target" ];

    # Extra binaries added to this unit’s PATH
    path = with pkgs; [
      bashInteractive # NOTE: Makes /usr/bin/env bash resolve
      coreutils
      findutils
      gnugrep
      gnused
      fuzzel
      jq
      wl-clipboard
    ];

    # Variables your shell scripts expect
    environment = {
      LOCALE_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
      TZDIR = "${pkgs.tzdata}/share/zoneinfo";
      XDG_BIN_HOME = "%h/.local/bin"; # %h expands to /home/zayron
    };

    serviceConfig = {
      Type = "simple";
      User = "zayron"; # run as your user
      Nice = "-5";
      Restart = "no";

      # Wait until the keyboard appears
      ExecStartPre = "${pkgs.bash}/bin/bash -c 'until [ -e /dev/input/by-id/usb-Keychron_Keychron_V1-event-kbd ]; do sleep 0.5; done'";

      # Launch KMonad with your layout
      ExecStart = ''
        ${pkgs.kmonad}/bin/kmonad /home/zayron/.config/kmonad/keychron.kbd
      '';
    };
  };
}
