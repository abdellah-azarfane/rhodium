{
  waybarModules = {
    cpu = {
      interval = 1;
      format = "⚙ {usage}%";
      format-alt = "⚙ U {usage}% L {load}% AVG {avg_frequency}GHz MAX {max_frequency}GHz MIN {min_frequency}GHz";
      format-icons = [
        "[⠀]"
        "[⢀]"
        "[⣀]"
        "[⣠]"
        "[⣤]"
        "[⣴]"
        "[⣶]"
        "[⣾]"
        "[⣿]"
      ];
      tooltip = true;
      tooltip-format = ''
        ⚙ CPU
        ━━━━━━━━━━━━━━━━━━
        • Usage ⟶ {usage}%
        • Load ⟶ {load}
        • Avg Freq ⟶ {avg_frequency}GHz
        • Max Freq ⟶ {max_frequency}GHz
        • Min Freq ⟶ {min_frequency}GHz
      '';
      on-click-right = "$XDG_BIN_HOME/launchers/launchers-btop.sh";
    };
  };
}
