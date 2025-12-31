{ ... }:
let
  c = (import ../../../../assets/colors/kanso-palette.nix).base;

  i = {
    icon01 = "◆";
  };
in
let
  viaColor = c.color18;
  colors = c;
in
{
  programs.starship.settings = {
    custom.rhodium = {
      disabled = true;
      command = "echo 'Rh'";
      when = "true";
      format = "[$output]($style) ${i.icon01} ";
      style = "#A4A7A4";
    };
  };
}
