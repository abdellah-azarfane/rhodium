{ ... }:
{
  programs.nushell.extraConfig = ''
    # -------------------------------------
    # NAVIGATION
    # -------------------------------------

    # Yazi: Exit and change directory
    def --env yy [...args] {
      let tmp = (mktemp -t "yazi-cwd.XXXXXX")
      yazi ...$args --cwd-file=$tmp
      if ($tmp | path exists) {
        let cwd = (open $tmp | str trim)
        if ($cwd | is-not-empty) and ($cwd != $env.PWD) {
          cd $cwd
        }
      }
      rm -f $tmp
    }

    # Mkdir and CD immediately
    def --env mkz [dir: path] {
      mkdir -p $dir
      cd $dir
    }

    # Interactive Zoxide (Smart CD)
    def --env zi [...args] {
      let result = (zoxide query -i ...$args | str trim)
      if ($result | is-not-empty) {
        cd $result
      }
    }

    # -------------------------------------
    # UTILITIES
    # -------------------------------------

    # Smart Extract: Unzip anything
    def xrt [...files] {
      for file in $files {
        if ($file | path exists) {
          match ($file | path parse | get extension) {
            "tar.bz2" | "tbz2" => { tar xjf $file }
            "tar.gz" | "tgz"   => { tar xzf $file }
            "zip"              => { unzip $file }
            "7z"               => { 7z x $file }
            "rar"              => { unrar x $file }
            _                  => { print $"Unknown archive format: ($file)" }
          }
        } else {
          print $"($file) not found"
        }
      }
    }

    # Backup a file with timestamp
    def bkp [file: path] {
      let timestamp = (date now | format date "%Y%m%d-%H%M%S")
      cp $file $"($file).bak.($timestamp)"
    }

    # Run last command as Sudo
    def --env "!!" [] {
      let last_cmd = (history | last | get command)
      sudo $last_cmd
    }

    # -------------------------------------
    # FUZZY FINDERS (FZF)
    # -------------------------------------

    # Jump to File
    def jtf [] {
      let file = (fd -t f | fzf --preview 'bat --color=always {}' | str trim)
      if ($file | is-not-empty) { ^$env.EDITOR $file }
    }

    # Jump to Directory
    def --env jtd [] {
      let dir = (fd -t d | fzf --preview 'eza --tree --level=2 {}' | str trim)
      if ($dir | is-not-empty) { cd $dir }
    }
  '';
}
