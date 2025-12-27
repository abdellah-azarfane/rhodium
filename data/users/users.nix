{
  users = {
    user_001 = {
      username = "zayron";
      fullName = "Abdellah Azarfane";
      emailMain = "abdellahazarfane@proton.me";
      extraGroups = [
        "wheel"
        "networkmanager"
        "docker"
        "input"
        "uinput"
        "video"
      ]; # NOTE: uinput required by kmonad
      isNormalUser = true;
      shell = "zsh";
    };
  };
}
