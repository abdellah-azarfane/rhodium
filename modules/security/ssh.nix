{ lib, ... }:
{
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    openFirewall = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      PubkeyAuthentication = true;
    };
  };
  services.gnome.gcr-ssh-agent.enable = lib.mkForce false;
  programs.ssh = {
    startAgent = true;
  };
}
