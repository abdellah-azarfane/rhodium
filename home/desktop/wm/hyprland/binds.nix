{
  ...
}:
{
  wayland.windowManager.hyprland.settings = {
    bind = [
      # Core
      # ----------------------------------------

      # Tier 1
      "$mainMod, W, exec, wezterm"
      "$mainMod, B, exec, brave" # TODO: Glue to main browser profile declaratively
      "$mainMod, F, exec, toggle fullscreen"
      "$mainMod, E, exec, wezterm -e vw"
      "$mainMod, I, exec, zeditor"

      # Tier 2 (Fallbacks)
      "$mainMod SHIFT, W, exec, ghostty"
      "$mainMod SHIFT, B, exec, librewolf"
      "$mainMod SHIFT, F, exec, dolphin"
   #   "$mainMod SHIFT, E, exec, ${preferredApps.terminal} -e ${preferredApps.editorAlt}"
   #   "$mainMod SHIFT, I, exec, ${preferredApps.ideAlt}"

      # Tier 3 (Secondary menus & appearance)

      # Cycles
      "$mainMod ALT, H, exec, hyprlock"

      # Kills
      "$mainMod, C, killactive" # Ask
      "$mainMod SHIFT, C, exec, hyprctl dispatch killactive" # Demand
      "$mainMod CTRL, C, exec, pkill -9 $(hyprctl activewindow -j | jq -r '.pid')" # Nuke

      # Floating
      "$mainMod, V, togglefloating"

      # Rotate
      "$mainMod, J, togglesplit"

      # Focus
      "$mainMod, left, movefocus, l"
      "$mainMod, right, movefocus, r"
      "$mainMod, up, movefocus, u"
      "$mainMod, down, movefocus, d"

      # Workspaces
      # ----------------------------------------
      # Workspaces jump
      "$mainMod, 1, workspace, 1"
      "$mainMod, 2, workspace, 2"
      "$mainMod, 3, workspace, 3"
      "$mainMod, 4, workspace, 4"
      "$mainMod, 5, workspace, 5"
      "$mainMod, 6, workspace, 6"
      "$mainMod, 7, workspace, 7"
      "$mainMod, 8, workspace, 8"
      "$mainMod, 9, workspace, 9"
      "$mainMod, 0, workspace, 10"

      # Workspaces navigate
      "$mainMod SHIFT, right, workspace, e+1"
      "$mainMod SHIFT, left, workspace, e-1"

      # Workspaces send
      "$mainMod SHIFT, 1, movetoworkspace, 1"
      "$mainMod SHIFT, 2, movetoworkspace, 2"
      "$mainMod SHIFT, 3, movetoworkspace, 3"
      "$mainMod SHIFT, 4, movetoworkspace, 4"
      "$mainMod SHIFT, 5, movetoworkspace, 5"
      "$mainMod SHIFT, 6, movetoworkspace, 6"
      "$mainMod SHIFT, 7, movetoworkspace, 7"
      "$mainMod SHIFT, 8, movetoworkspace, 8"
      "$mainMod SHIFT, 9, movetoworkspace, 9"
      "$mainMod SHIFT, 0, movetoworkspace, 10"
    ];

    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];

    bindel = [
        # speaker and mic volume control
        " , XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 10%+"
        " , XF86AudioLowerVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 10%-"
        " , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        " , XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
    ];

    bindl = [
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioNext, exec, playerctl next"
      ", XF86AudioPrev, exec, playerctl previous"
    ];

    binde = [
      # resize active
      "SUPER_CTRL, left,  resizeactive, -20 0"
      "SUPER_CTRL, right, resizeactive, 20 0"
      "SUPER_CTRL, up,    resizeactive, 0 -20"
      "SUPER_CTRL, down,  resizeactive, 0 20"

      # move active (Floating Only)
      "SUPER_ALT, left,  moveactive, -20 0"
      "SUPER_ALT, right, moveactive, 20 0"
      "SUPER_ALT, up,    moveactive, 0 -20"
      "SUPER_ALT, down,  moveactive, 0 20"
      "SUPER_ALT, equal, exec, hyprctl dispatch centerwindow;"

      # display and keyboard brightness control
      " , XF86MonBrightnessUp, exec, brightnessctl s +20%"
      " , XF86MonBrightnessDown, exec, brightnessctl s 20%-"
      " , XF86KbdBrightnessUp, exec, asusctl -n"
      " , XF86KbdBrightnessDown, exec, asusctl -p"

      # performance
      " , XF86Launch4, exec, asusctl profile -n"
      ];
  };
}
