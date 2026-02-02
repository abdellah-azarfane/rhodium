{
  apps = {
    # Core
    shell = "zsh";
    shelAlt = "fish";
    terminal = "wezterme";
    terminalAlt = "kitty";
    browser = "firefox";
    browserAlt = "brave";
    wm = "niri";

    # Files
    editor = "nvim";
    editorAlt = "hx";
    ide = "zeditor";
    ideAlt = "codium";
    filesTerminal = "yazi";
    filesGraphic = "thunar";

    # Media
    imageViewer = "imv";
    videoPlayer = "mpv";
    audioPlayer = "mpv";

    # Productivity
    pdfViewer = "org.pwmt.zathura";
    pager = "most";
  };

  profiles = {
    firefox = {
      personal = "Personal";
      media = "Media";
      fr = "France";
      academic = "Academic";
      bsogood = "Bsogood";
      phantom = "TheHumanPalace";
      genai = "GenAI";
      genai-2 = "GenAI-2";
      amsterdam = "Amsterdam";
      ultra = "Ultra";
      segmentaim = "Segmentaim";
      atmosphericai = "AtmosphericAI";
      private = "Private";
    };

    zen = {
      personal = "Personal";
      work = "Work-Zen";
      media = "Entertainment";
      dev = "Dev-Profile";
    };

    chromium = {
      personal = "Default";
      work = "Work";
      media = "Media";
    };

    brave = {
      personal = "Person 1";
      work = "Work";
      media = "Media";
    };
  };
}
