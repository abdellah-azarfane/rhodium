{
  user,
  pkgs,
  ...
}:
let
  userfullName = user.fullName;
  userEmailMain = user.emailMain;
in
{
  home.packages = with pkgs; [
    commitizen # Commit rules for projects
    serie # Rich TUI commit graph
    tig # Text-mode interface for git
  ];

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = userfullName;
        email = userEmailMain;
      };
      extraConfig = {
        init.defaultBranch = "main";
      };
    };
    ignores = [
      # Editor files
      "*~"
      "*.swp"
      "*.swo"
      ".vscode/"
      ".idea/"

      # OS files
      ".DS_Store"
      "Thumbs.db"

      # Build artifacts
      "*.o"
      "*.so"
      "*.a"
      "*.out"

      # Logs
      "*.log"

      # Temporary files
      "*.tmp"
      "*.bak"
      ".cache/"
    ];
  };

  programs.riff = {
    enable = false; # View file diffs. Either this or delta.
  };

  programs.delta = {
    enable = true; # View file diffs
    enableGitIntegration = true;
  };

  programs.gh = {
    enable = true; # GitHub CLI Tool
  };

  programs.gitui = {
    enable = true; # Blazing fast terminal-ui for Git written in Rust
  };

  programs.lazygit = {
    enable = true; # Simple terminal UI for git commands
  };
}
