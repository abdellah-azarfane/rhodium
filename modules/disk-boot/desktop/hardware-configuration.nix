{ config, lib, ... }:
let
	cfg = config.diskBoot;
in
lib.mkIf (cfg.enable && (cfg.profile == "desktop" || cfg.profile == "server")) { }
