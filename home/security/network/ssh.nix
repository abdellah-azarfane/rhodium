{ lib, ... }:
{
  services.ssh-agent.enable = true;

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks."*" = {
      addKeysToAgent = "yes";
      identityFile = [ "~/.ssh/GitHub_NixOS" ];
    };
  };

  home.activation.installAuthorizedKeys = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        # ensure ~/.ssh directory exists with correct perms
        mkdir -p "$HOME/.ssh"
        chmod 700 "$HOME/.ssh"

        # write authorized_keys
        cat > "$HOME/.ssh/authorized_keys" <<'EOF'
    ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPVbCu5j2dSjhn1y8zrsj1YjVaKByDy/Ezw4RMxwECqJ abdellahazarfane@proton.me
    EOF

        # set proper ownership and perms
        chown "$USER":"$(id -gn $USER)" "$HOME/.ssh/authorized_keys"
        chmod 600 "$HOME/.ssh/authorized_keys"
  '';
}
