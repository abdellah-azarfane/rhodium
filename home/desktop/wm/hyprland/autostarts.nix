{ pkgs, ... }:
{
   wayland.windowManager.hyprland.settings = {
      exec-once = [
   #   "dms" "run"
   #   "noctalia-shell"
      "swww-daemon&"
      ];
   };
}
