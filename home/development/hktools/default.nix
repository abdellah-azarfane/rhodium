{ config
, lib
, pkgs
, ...
}:
with lib;
let
  pkgIf = name: lib.optionals (builtins.hasAttr name pkgs) [ pkgs.${name} ];
in
{
  options = {
    programs.development.hktools = {
      enable = mkEnableOption "Authorized security testing tools";
    };
  };

  config = mkIf config.programs.development.hktools.enable {
    home.packages = [
      # Recon / networking
      pkgs.nmap
      pkgs.tcpdump

      # Password auditing / brute-force tooling (use only on systems you own or have explicit permission to test)
      pkgs.hydra
      pkgs.hydra-cli

      # Web testing helpers
      pkgs.sqlmap
      pkgs.nikto
    ]
    # Optional tools (guarded to avoid eval breakage if missing)
    ++ pkgIf "ffuf"
    ++ pkgIf "gobuster"
    ++ pkgIf "whatweb"
    ++ pkgIf "masscan"
    ++ pkgIf "rustscan"
    ++ pkgIf "wfuzz"
    ++ pkgIf "hashcat"
    ++ pkgIf "john";
  };
}
