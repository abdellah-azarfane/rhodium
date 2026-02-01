{
	config,
	lib,
	...
}:
with lib;
let
	cfg = config.diskBoot;
in
{
	options.diskBoot = {
		enable = mkEnableOption "Disk/boot configuration";

		profile = mkOption {
			type = types.enum [
				"laptop"
				"desktop"
				"server"
			];
			default = "laptop";
			description = "Select which disk/boot profile to apply.";
		};
	};

	imports = [
		./laptop
		./desktop
	];

	config = mkIf (cfg.enable && cfg.profile == "server") {
		warnings = [
			"diskBoot.profile = \"server\" is deprecated; it now maps to \"desktop\"."
		];
	};
}
