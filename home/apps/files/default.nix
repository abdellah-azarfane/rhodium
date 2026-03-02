{ pkgs, ... }:
{
  imports = [
    # ./krusader.nix # The heavy-duty option
    # ./pcmanfm.nix # The efficient option
    ./dolphine.nix
    ./thunar.nix # The in-between option
  ];

  home.packages = with pkgs; [
    filezilla # FTP client
 #   celeste # File sync client supporting ProtonDrive
  ];
}
