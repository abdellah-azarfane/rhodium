{ config, lib, ... }:
with lib;
let
  cfg = config.drivers.intelCpu;
in
{
  options.drivers.intelCpu = {
    enable = mkEnableOption "Intel CPU configuration";
  };

  config = mkIf cfg.enable {
    hardware.cpu.intel.updateMicrocode = mkDefault config.hardware.enableRedistributableFirmware;
  };
}
