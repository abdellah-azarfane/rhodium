{
  waybarModules = {
    "custom/thm-cpu" = {
      exec = "$XDG_BIN_HOME/waybar/custom-thermals.sh";
      return-type = "json";
      format = "○ {text}";
      tooltip = true;
      tooltip-format = "CPU";
      interval = 1;
    };
  };
}
