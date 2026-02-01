{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.drivers;

  cpuEnableCount = length (filter (x: x) [
    (config.drivers.amdCpu.enable or false)
    (config.drivers.intelCpu.enable or false)
  ]);

  gpuEnableCount = length (filter (x: x) [
    (config.drivers.amdGpu.enable or false)
    (config.drivers.intelGpu.enable or false)
    (config.drivers.nvidiaDe.enable or false)
    (config.drivers.nvidiaLaptop.enable or false)
  ]);
in
{
  imports = [
    ./amd-cpu
    ./amd-gpu
    ./intel-cpu
    ./intel-gpu
    ./nvidia-de
    ./nvidia-laptop
  ];

  options.drivers = {
    cpu = mkOption {
      type = types.nullOr (types.enum [ "intel" "amd" "none" ]);
      default = null;
      description = "Select the CPU vendor to enable microcode updates for (sets the matching drivers.*Cpu.enable).";
      example = "intel";
    };

    gpu = mkOption {
      type = types.nullOr (types.enum [ "intel" "amd" "nvidia" "nvidia-de" "nvidia-laptop" "none" ]);
      default = null;
      description = ''
        Select the GPU driver profile to enable (sets the matching drivers.*Gpu/nvidia*.enable).

        - \"nvidia\" is an alias for \"nvidia-de\".
      '';
      example = "nvidia";
    };
  };

  config = mkMerge [
    (mkIf (cfg.cpu == "intel") { drivers.intelCpu.enable = mkDefault true; })
    (mkIf (cfg.cpu == "amd") { drivers.amdCpu.enable = mkDefault true; })
    (mkIf (cfg.cpu == "none") { })

    (mkIf (cfg.gpu == "intel") { drivers.intelGpu.enable = mkDefault true; })
    (mkIf (cfg.gpu == "amd") { drivers.amdGpu.enable = mkDefault true; })
    (mkIf ((cfg.gpu == "nvidia") || (cfg.gpu == "nvidia-de")) {
      drivers.nvidiaDe.enable = mkDefault true;
    })
    (mkIf (cfg.gpu == "nvidia-laptop") { drivers.nvidiaLaptop.enable = mkDefault true; })
    (mkIf (cfg.gpu == "none") { })

    {
      assertions = [
        {
          assertion = cpuEnableCount <= 1;
          message = "Only one CPU driver module may be enabled at a time (choose one of drivers.amdCpu.enable or drivers.intelCpu.enable, or use drivers.cpu).";
        }
        {
          assertion = gpuEnableCount <= 1;
          message = "Only one GPU driver module may be enabled at a time (choose one of drivers.{intelGpu,amdGpu,nvidiaDe,nvidiaLaptop}.enable, or use drivers.gpu).";
        }
      ];
    }
  ];
}
