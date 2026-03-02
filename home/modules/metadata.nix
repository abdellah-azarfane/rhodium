{
  config,
  pkgs,
  irixLib,
  userPreferences,
  ...
}:
{
  home.file."${config.xdg.dataHome}/irix-utils/metadata.json".source =
    pkgs.writeText "irix-utils-metadata.json" (
      builtins.toJSON (irixLib.generators.utilsMetadataGenerators userPreferences.metadata)
    );
}
