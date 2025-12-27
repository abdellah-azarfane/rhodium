{
  hosts = {
    host_001 = {
      hostname = "laptop";
      description = "main Host";
      mainMonitor = {
        monitorID = "eDP-1";
        monitorResolution = "1920x1080";
        monitorRefreshRate = "144";
        monitorScalingFactor = "1.0";
      };
      defaultLocale = "";
    };

    host_002 = {
      hostname = "alexandria";
      description = "Alexandria Host";
      mainMonitor = {
        monitorID = "eDP-2";
        monitorResolution = "1920x1080";
        monitorRefreshRate = "300";
        monitorScalingFactor = "1.0";
      };
      defaultLocale = "";
    };
  };
}
