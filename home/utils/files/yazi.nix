{ pkgs
, ...
}:
{
  imports = [
    ./yazi/modules
  ];

  programs.yazi = {
    enable = true;
    # package = pkgs.yazi;
    package = pkgs.yazi; # NOTE: Using unstable for now due to some plugin requirements
  };
}
