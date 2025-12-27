{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ auto-cpufreq ];
  services.auto-cpufreq.enable = true;
  services.tlp = {
   enable = true;
     settings = {
    CPU_SCALING_GOVERNOR_ON_AC = "performance";
    CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    CPU_ENERGY_PERF_POLICY_ON_BAT = "balance";
    CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
    CPU_DRIVER_OPMODE_ON_AC = "active";
    CPU_DRIVER_OPMODE_ON_BAT = "active";

    WIFI_PWR_ON_AC = "on";
    WIFI_PWR_ON_BAT = "on";
    RUNTIME_PM_ON_AC = "auto";
    RUNTIME_PM_ON_BAT = "auto";
    RUNTIME_PM_DRIVER_BLACKLIST = ["nvidia"];

    CPU_MIN_PERF_ON_AC = 10;
    CPU_MAX_PERF_ON_AC = 90;
    CPU_MIN_PERF_ON_BAT = 10;
    CPU_MAX_PERF_ON_BAT = 50;

    CPU_BOOST_ON_AC = 1;
    CPU_BOOST_ON_BAT = 0;
    CPU_HWP_DYN_BOOST_ON_AC = 1;
    CPU_HWP_DYN_BOOST_ON_BAT = 0;

    START_CHARGE_THRESH_BAT0 = 60;
    STOP_CHARGE_THRESH_BAT0 = 80;

    MEM_SLEEP_ON_AC = "deep";
    MEM_SLEEP_ON_BAT = "deep";

    PLATFORM_PROFILE_ON_AC = "performance";
    PLATFORM_PROFILE_ON_BAT = "low-power";

    INTEL_GPU_MIN_FREQ_ON_AC = 600;
    INTEL_GPU_MIN_FREQ_ON_BAT = 600;

    NVREG_POWERMIZER_MODE_ON_AC = "1";
    NVREG_POWERMIZER_MODE_ON_BAT = "0";
    NVIDIA_PERSISTENT_MODE_ON_AC = 1;
    NVIDIA_PERSISTENT_MODE_ON_BAT = 0;
  };
};

}
