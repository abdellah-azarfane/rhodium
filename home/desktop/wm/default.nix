{ lib, osConfig ? { }, ... }:

let
  style =
    if osConfig ? desktop && osConfig.desktop ? wm && osConfig.desktop.wm ? type then osConfig.desktop.wm.type
    else "hyprland";

  importsFor = s:
    if s == "hyprland" then [ ./hyprland.nix ]
    else if s == "niri" then [ ./niri.nix ]
    else if s == "sway" then [ ./sway.nix ]
    else if s == "i3" then [ ./i3.nix ]
    else if s == "river" then [ ./river.nix ]
    else if s == "mangowc" then [ ./mangowc.nix ]
    else [ ];
in
{
  imports = importsFor style;
}
