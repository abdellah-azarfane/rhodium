{ lib, pkgs, ... }:

{
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3;

    config = {
      modifier = "Mod4";
      terminal = "kitty";
      menu = "rofi -show drun";

      keybindings = lib.mkOptionDefault {
        "Mod4+Return" = "exec kitty";
        "Mod4+d" = "exec rofi -show drun";
        "Mod4+Shift+q" = "kill";
        "Mod4+Shift+r" = "restart";
      };
    };
  };
}
