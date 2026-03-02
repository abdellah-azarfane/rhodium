{ ... }:
{
  programs.ghostty = {
    settings = {
      # General
      resize-overlay = "never";
      link-url = true;
      scrollback-limit = 10000;

      # Theme
     # theme = "catppuccin-mocha";

      # Typography
      font-family = "BerkeleyMonoRh Nerd Font";
      font-style = "Regular";
      # font-size = 13;

      # Cursor
      cursor-style = "block";
      cursor-style-blink = false; # Enforce no blinking (shell vi mode can interfere)
      shell-integration-features = "no-cursor";
      adjust-cursor-thickness = "2"; # Make cursor line thicker

      # Clipboard
      clipboard-read = "allow";
      clipboard-write = "allow";

      # UI
      window-padding-x = 20;
      window-padding-y = 10;
      window-padding-balance = true;
      background-opacity = 0.70; # This is controlled by the compositor instead
      background-blur = 5;
      mouse-hide-while-typing = true;

      # Performance
      linux-cgroup-memory-limit = 0;
    };
  };
}
