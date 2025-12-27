{ ... }:
{
  imports = [
    ./audio.nix
    ./battery.nix
    ./bluetooth.nix
    ./keyboard.nix
    ./mouse.nix
    ./network.nix
    ./printers.nix
    ./storage.nix
    ./power.nix
    ./video.nix
  ];

  services.udev = {
    enable = true; # Enable device manager
  };
}
