{
  pkgs,
  ...
}:
{
  home.pointerCursor = {
    enable = true;

    package = pkgs.phinger-cursors;
    name = "phinger-cursors-dark";
    size = 32;

    # Desktops
    gtk.enable = true;
    x11.enable = true;
  };
}
