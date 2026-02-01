{ config, ... }:
{
  programs.nushell = {
    # 1. CONSTANTS & SHORTCUTS
    environmentVariables = {
      # Directories
      RHODIUM = "$HOME/dev/rhodium/";
      HOME_PROJECTS = "$HOME/dev/utils/";
      HOME_PROFESSIONAL = "$HOME/professional/";
      HOME_ACADEMIC = "$HOME/academic/";
      HOME_DOWNLOADS = "$HOME/downloads/";

      # Apps
      EDITOR = "nvim";
      VISUAL = "nvim";
      TERMINAL = "kitty";
      PAGER = "bat";

      # Tool Settings
      BAT_THEME = "TwoDark";
      FZF_DEFAULT_OPTS = "--height 40% --layout=reverse --border";
      _ZO_ECHO = "1";
    };

    # 2. CORE SHELL LOGIC
    extraEnv = ''
      # Path Conversions (Crucial for NixOS)
      $env.ENV_CONVERSIONS = {
        "PATH": {
          from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
          to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
        }
        "Path": {
          from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
          to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
        }
      }

      # Add User Binaries to Path
      $env.PATH = ($env.PATH | split row (char esep) | prepend [
        $"($env.HOME)/.local/bin"
        $"($env.HOME)/.cargo/bin"
        "/etc/profiles/per-user/($env.USER)/bin"
      ])

      # Plugin Directories
      $env.NU_LIB_DIRS = [ ($nu.default-config-dir | path join 'scripts') ]
      $env.NU_PLUGIN_DIRS = [ ($nu.default-config-dir | path join 'plugins') ]
    '';
  };
}
