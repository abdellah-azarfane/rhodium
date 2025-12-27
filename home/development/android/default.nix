{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    android-tools
    android-studio
    qtscrcpy
    scrcpy
    openjdk17
    android-studio-tools
    android-file-transfer
    android-backup-extractor
    gradle
    maven
    protobuf
  ];
}
