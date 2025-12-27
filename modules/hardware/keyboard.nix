
{ pkgs, ... }:
# TODO: Dynamic
{
  environment.systemPackages = with pkgs; [
    xorg.xev # xorg key registry
  ];

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
}
