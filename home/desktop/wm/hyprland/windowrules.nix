{ ... }:
{
  wayland.windowManager.hyprland = {
    settings = {
      windowrulev2 = [
        "suppressevent maximize, class:.*"

        # Transparency
        "opacity 0.95,class:^(.*)$" # All windows

        # "opacity 0.95, class:(zen-alpha)" # Zen
        # "opacity 0.95, class:(code)" # vs code
        # "opacity 0.95, class:(firefox)" # firefox
        # "opacity 0.95, class:(zen-alpha)" # zen



      ];

      layerrule = [
   #     "noanim, ^(rofi)$"
   #     "noanim, ^(fuzzel)$"
   #     "noanim, ^(raffi)$"
      ];
    };
  };
}
