{
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./bar
    ./files
    ./fonts
    ./notifications
  ];
}
