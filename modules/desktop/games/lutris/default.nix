{ pkgs, lib, ...  }:
{

  # === Gaming / Wine / Proton ===
  environment.systemPackages = with pkgs; [
 #   lutris                   # Game manager / launcher
    wine                     # Windows compatibility layer
    winetricks               # Helper scripts for Wine
    gamemode                 # Optimizes system for gaming
    dxvk                     # DirectX → Vulkan translation
    wineWowPackages.staging  # Wine staging packages for 32-bit apps
    heroic                   # Epic Games / GOG launcher
    mangohud                 # On-screen performance overlay
    protonup-qt              # Install and manage Proton-GE and Luxtorpeda for Steam and Wine-GE for Lutris with this graphical user interface
    protonup-ng              # CLI program and API to automate the installation and update of GloriousEggroll's Proton-GE
  ];

  # Enable Gamemode for system-wide performance optimization
  programs.gamemode.enable = true;
}

