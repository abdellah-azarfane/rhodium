{ pkgs, lib, ... }:
let
  ccVersion = pkgs.stdenv.cc.version or "";
  gccIsTooNewForGlslls = ccVersion != "" && lib.versionAtLeast ccVersion "15";

  glslLspPkg =
    if pkgs ? shader-language-server then
      pkgs.shader-language-server
    else if (pkgs ? glslls) && (!gccIsTooNewForGlslls) then
      pkgs.glslls
    else
      null;
in
{
  home.packages = lib.filter (p: p != null) [
    # --- Glsl ---
    glslLspPkg
  ];
}
