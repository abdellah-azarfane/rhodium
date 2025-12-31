{ rhodiumRoot }:
{
  host_001 = {
    system = "x86_64-linux";
    disko = true;

    home = {
      includeChiaroscuroTheme = true;
      includeModuleGenerators = true;
    };
  };

  host_002 = {
    system = "x86_64-linux";
  };
}
