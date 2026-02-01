# TODO: Complete this module
# ---------------------------------------------------------
# CUSTOM NUSHELL FUNCTIONS
# ---------------------------------------------------------

# 1. Create a directory and enter it immediately
# Usage: mkcd my_new_project
def --env mkcd [dirname: path] {
    mkdir $dirname
    cd $dirname
}

# 2. Universal Extractor
# Usage: extract file.tar.gz
def extract [file: path] {
    if ($file | path exists) {
        match ($file | path parse | get extension) {
            "tar.gz" | "tgz" => { tar xzf $file }
            "tar.bz2" | "tbz2" => { tar xjf $file }
            "tar.xz" | "txz" => { tar xJf $file }
            "zip" => { unzip $file }
            "7z" => { 7z x $file }
            "rar" => { unrar x $file }
            _ => { print $"Unknown extension for ($file)" }
        }
    } else {
        print $"File ($file) not found"
    }
}

# 3. Quick Git Sync (Add, Commit, Push)
# Usage: gsync "fixed bug"
def gsync [message: string = "wip"] {
    git add .
    git commit -m $message
    git push
}

# 4. Backup a file with a timestamp
# Usage: bkp config.nix (Creates config.nix.bak.2024...)
def bkp [file: path] {
    let timestamp = (date now | format date "%Y%m%d-%H%M%S")
    cp $file $"($file).bak.($timestamp)"
}

# 5. Get current weather
# Usage: weather "London" or just weather
def weather [location?: string] {
    let loc = if ($location == null) { "" } else { $location }
    http get $"https://wttr.in/($loc)?format=3"
}