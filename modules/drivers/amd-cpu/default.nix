{ config, lib, ... }:
with lib;
let
  cfg = config.drivers.amdCpu;
in
{
  options.drivers.amdCpu = {
    enable = mkEnableOption "AMD CPU configuration";
  };

  config = mkIf cfg.enable {
    hardware.cpu.amd.updateMicrocode = mkDefault config.hardware.enableRedistributableFirmware;
  };
}
