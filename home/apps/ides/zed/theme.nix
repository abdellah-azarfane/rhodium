{ ... }:
{
  programs.zed-editor = {
    userSettings = {
    theme = {
       mode = "system";
       light = "Kanagawa Lotus";
       dark = "Kanagawa Dragon";
       # Add Foxnight themes as options
      foxnight = {
        theme1 = "Nightfox";
        theme2 = "Duskfox";
        theme3 = "Dayfox";
        theme4 = "Dawnfox";
        theme5 = "Nordfox";
        theme6 = "Terafox";
        theme7 = "Carbonfox";
        };
      };
      icon_theme = "Catppuccin Mocha";
    };
  };
}
