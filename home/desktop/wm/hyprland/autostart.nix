{ pkgs, ... }:
{
   wayland.windowManager.hyprland.settings = {
      exec-once = [
      "swww-daemon&"
      ];
   };
}
