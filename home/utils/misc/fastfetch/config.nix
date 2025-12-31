{ lib, config }:
let
  c = (import ../../../assets/colors/kanso-palette.nix).base;
  icons = import ./icons.nix;
in
{
  "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/master/doc/json_schema.json";

  logo = {
    type = "file";
    source = "${config.xdg.dataHome}/ascii/rhodium-neo.txt";
    color = {
      "1" = c.color19;
    };
    padding = {
      top = 1;
      right = 4;
      left = 2;
    };
  };

  display = {
    separator = "";
    color = {
      keys = c.color18;
      output = c.color15;
      separator = c.color0;
    };
    key = {
      width = 12;
    };
    bar = {
      char = {
        elapsed = "─";
        total = "─";
      };
      border = {
        left = "";
        right = "";
        leftElapsed = "";
        rightElapsed = "";
      };
      width = 16;
    };
    percent = {
      type = 1;
    };
  };

  modules = import ./modules.nix { inherit icons; };
}
