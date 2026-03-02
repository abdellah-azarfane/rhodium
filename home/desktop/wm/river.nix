{ pkgs, ... }:

{
  home.packages = [ pkgs."river-classic" ];

  xdg.configFile."river/init" = {
    executable = true;
    text = ''
      #!/usr/bin/env sh
      riverctl default-layout rivertile

      riverctl set-repeat 50 300

      riverctl map normal Super Return spawn kitty
      riverctl map normal Super D spawn "rofi -show drun"
      riverctl map normal Super Shift Q exit

      riverctl map normal Super H focus-view left
      riverctl map normal Super J focus-view down
      riverctl map normal Super K focus-view up
      riverctl map normal Super L focus-view right

      riverctl map normal Super Shift H swap left
      riverctl map normal Super Shift J swap down
      riverctl map normal Super Shift K swap up
      riverctl map normal Super Shift L swap right

      riverctl map normal Super Space toggle-float
    '';
  };
}
