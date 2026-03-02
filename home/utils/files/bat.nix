{ ... }:
{
  programs.bat = {
    enable = true;
  };

  xdg.configFile."bat/syntaxes/Just.sublime-syntax" = {
    source = ./bat/syntaxes/Just.sublime-syntax;
    force = true;
  };

  xdg.configFile."bat/syntaxes/KDL.sublime-syntax" = {
    source = ./bat/syntaxes/KDL.sublime-syntax;
    force = true;
  };
  xdg.configFile."bat/syntaxes/nushell.sublime-syntax" = {
    source = ./bat/syntaxes/nushell.sublime-syntax;
    force = true;
  };
}
