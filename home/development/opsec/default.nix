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
    programs.development.opsec = {
      enable = mkEnableOption "OpSec Suite";
    };
  };
  config = mkIf config.programs.development.opsec.enable {
    home.packages = [
      # --- Binary Analysis And Reverse Engineering ---
      pkgs.apktool # Android APK reverse engineering tool
      pkgs.ghidra # Software reverse engineering suite by NSA
      pkgs.radare2 # Reverse engineering framework and hex editor

      # --- Brute Forcing And Password Cracking ---
      pkgs.aircrack-ng # Wireless network security assessment tools
      pkgs.hashcat # Advanced GPU-based password recovery utility
      pkgs.hydra # Fast and flexible network logon cracker
      pkgs.hydra-cli # Command-line interface for Hydra
      pkgs.john # John the Ripper password security auditing
      pkgs.johnny # GUI frontend for John the Ripper
      pkgs.thc-hydra # THC version of Hydra network authentication cracker

      # --- Browser ---
      pkgs.tor # Anonymous communication and browsing network

      # --- Exploitation Frameworks ---
      pkgs.metasploit # Penetration testing and exploit development framework

      # --- Forensics And Incident Response ---
      pkgs.autopsy # Digital forensics platform and GUI
      pkgs.maltego # Open source intelligence and forensics application

      # --- Information Gathering ---
      pkgs.nmap # Advanced network scanner and security auditing tool
      pkgs.social-engineer-toolkit # Social engineering penetration testing framework
      pkgs.wpscan # WordPress vulnerability scanner

      # --- Network Analysis And Sniffing ---
      pkgs.kismet # Wireless network detector/sniffer
      pkgs.snort # Network intrusion detection system
      pkgs.wireshark # Network protocol analyzer with deep inspection
      pkgs.wireshark-qt # Qt-based GUI for Wireshark

      # --- Penetration Testing Tools ---
      pkgs.burpsuite # Web vulnerability scanner and intercepting proxy
      pkgs.lynis # Security auditing tool for Unix-based systems
      pkgs.nikto # Web server scanner for vulnerabilities
      pkgs.sqlmap # Automatic SQL injection and database takeover tool

      # --- Resources ---
      pkgs.wordlists # Collection of wordlists for password cracking

      # --- Vulnerability Scanning ---
      pkgs.gvm-tools # Greenbone tooling (gvm-cli, gvm-script)
      pkgs.openvas-scanner # OpenVAS scanner component
    ]
    # Optional meta-packages that may exist in overlays
    ++ pkgIf "kali-tools"
    ++ pkgIf "zaproxy";
  };
}
