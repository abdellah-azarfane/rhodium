{
  lib,
  pkgs,
  ...
}:
{
  # 1. Enable Carapace (The Universal Completer)
  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.nushell.extraConfig = ''
    # ---------------------------------------------------------
    # 1. DEFINE COMPLETERS
    # ---------------------------------------------------------

    # Zoxide Completer (For smart directory jumping)
    let zoxide_completer = {|spans|
      $spans | skip 1 | zoxide query -l ...$in | lines | where {|x| $x != $env.PWD}
    }

    # Carapace Completer (The main worker)
    # It automatically handles thousands of commands like git, cargo, docker, etc.
    let carapace_completer = {|spans|
      carapace $spans.0 nushell ...$spans | from json
    }

    # ---------------------------------------------------------
    # 2. THE ROUTER (Decides which completer to use)
    # ---------------------------------------------------------
    let external_completer = {|spans|
      let expanded_alias = scope aliases
        | where name == $spans.0
        | get -i 0.expansion

      let spans = if $expanded_alias != null {
        $spans | skip 1 | prepend ($expanded_alias | split row ' ' | take 1)
      } else {
        $spans
      }

      # The Logic:
      match $spans.0 {
        # When typing 'z' or 'zi', ask Zoxide
        z | zi | zoxide => $zoxide_completer
        
        # For EVERYTHING else, ask Carapace
        _ => $carapace_completer
      } | do $in $spans
    }

    # ---------------------------------------------------------
    # 3. ACTIVATE
    # ---------------------------------------------------------
    $env.config = ($env.config | merge {
      completions: {
        external: {
          enable: true
          completer: $external_completer
        }
      }
    })

    # ---------------------------------------------------------
    # 4. MANUAL OVERRIDES (Faster than external tools)
    # ---------------------------------------------------------

    # Git Branches
    def "nu-complete git branches" [] {
      ^git branch -a | lines | each { |line| $line | str replace '^\* ' "" | str trim }
    }

    # Git Remotes
    def "nu-complete git remotes" [] {
      ^git remote | lines | each { |line| $line | str trim }
    }

    # Custom Git Checkout
    export extern "git checkout" [
      branch?: string@"nu-complete git branches"
      --force(-f)
      --quiet(-q)
    ]

    # Custom Git Push
    export extern "git push" [
      remote?: string@"nu-complete git remotes"
      branch?: string@"nu-complete git branches"
      --force(-f)
      --set-upstream(-u)
      --verbose(-v)
    ]
  '';
}
