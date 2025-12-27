{ ... }:
{
  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };
 xdg.configFile."wezterm/wezterm.lua".source = ./wezterm/wezterm.lua;
}
