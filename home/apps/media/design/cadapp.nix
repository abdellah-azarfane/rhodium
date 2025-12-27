{ pkgs, ... }:
{
  home.packages = with pkgs; [
    freecad # An open-source parametric 3D modeler made primarily to design real-life objects of any size
  ];
}
