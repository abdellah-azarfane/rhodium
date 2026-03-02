{
  waybarModules = {
    "network#wifi-dl" = {
      interval = 1;
      format-wifi = "{bandwidthDownBytes:>} ↓";
      format-linked = "≏ No IP";
      format-disconnected = "⌽";
      tooltip = true;
      tooltip-format-wifi = ''Network
        ━━━━━━━━━━━━━━━━━━
        • SSID ⟶ {essid}
        • Signal ⟶ {signalStrength}%
        • Download ⟶ {bandwidthDownBytes}
        • IP ⟶ {ipaddr}'';
    };
  };
}
