{ self, ... }:
{
  flake.nixosModules.desktop =
    {
      pkgs,
      lib,
      ...
    }:
    let
      inherit (lib) getExe;
      selfpkgs = self.packages."${pkgs.stdenv.hostPlatform.system}";
    in
    {
      imports = [
        self.nixosModules.gtk
        self.nixosModules.wallpaper

        self.nixosModules.pipewire
        self.nixosModules.firefox
        self.nixosModules.chromium
      ];

      programs.niri.enable = true;
      programs.niri.package = selfpkgs.niri;

      # preferences.autostart = [selfpkgs.quickshellWrapped];
      preferences.autostart = [ selfpkgs.start-noctalia-shell ];

      environment.systemPackages = [
        selfpkgs.terminal
        pkgs.pcmanfm
        selfpkgs.noctalia-bundle
      ];

      fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
        ubuntu-sans
        cm_unicode
        corefonts
        unifont
      ];

      fonts.fontconfig.defaultFonts = {
        serif = [ "Ubuntu Sans" ];
        sansSerif = [ "Ubuntu Sans" ];
        monospace = [ "JetBrainsMono Nerd Font" ];
      };

      time.timeZone = "Africa/Casablanca"; # Time zone
      # Select internationalisation properties.
      i18n = {
        defaultLocale = "en_US.UTF-8";
        supportedLocales = [
          "en_US.UTF-8/UTF-8"
          "ar_MA.UTF-8/UTF-8"
          "fr_FR.UTF-8/UTF-8"
        ];
        extraLocaleSettings = {
          LC_ADDRESS = "ar_MA.UTF-8";
          LC_IDENTIFICATION = "ar_MA.UTF-8";
          LC_MEASUREMENT = "ar_MA.UTF-8";
          LC_MONETARY = "ar_MA.UTF-8";
          LC_NAME = "ar_MA.UTF-8";
          LC_NUMERIC = "ar_MA.UTF-8";
          LC_PAPER = "ar_MA.UTF-8";
          LC_TELEPHONE = "ar_MA.UTF-8";
          LC_TIME = "ar_MA.UTF-8";
        };
      };
      console.keyMap = "us"; # Default console Keymap

      services.xserver.xkb = {
        layout = "us";
        variant = "";
      };

      # NOTE: Required for kmonad
      hardware.uinput = {
        enable = true;
      };
      services.upower.enable = true;

      security.polkit.enable = true;

      hardware = {
        enableAllFirmware = true;
        bluetooth.enable = true;
        bluetooth.powerOnBoot = true;
      };
    };
}
