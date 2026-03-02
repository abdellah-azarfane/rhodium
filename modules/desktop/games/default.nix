 {
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./steam
    ./lutris
  ];
}

