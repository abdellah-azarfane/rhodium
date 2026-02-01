{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.nushell = {
    enable = true;
    settings = {
      show_banner = false;
      table = {
        mode = "rounded";
        index_mode = "always";
        show_empty = true;
      };
      history = {
        max_size = 100000;
        sync_on_enter = true;
        file_format = "sqlite";
      };
      completions = {
        algorithm = "fuzzy";
        external = {
          enable = true;
          max_results = 100;
        };
      };
    };
  };
}
