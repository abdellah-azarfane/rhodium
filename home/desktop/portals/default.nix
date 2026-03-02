{ lib, ... }:
{
  # Minimal: don't force GTK/Qt theme choices here.
  # Plasma/Stylix (and your own config) should own theme selection.
  gtk.enable = lib.mkDefault true;
  qt.enable = lib.mkDefault true;
}
