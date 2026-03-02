{ pkgs, inputs, ... }:

let
  system = pkgs.stdenv.hostPlatform.system;
  fenixPkgs = inputs.fenix.packages.${system};
  stableToolchain = fenixPkgs.stable.withComponents [
    "cargo"
    "clippy"
    "rust-src"
    "rustc"
    "rustfmt"
  ];
in
{
  home.packages = with pkgs; [
    # --- Rust ---
    stableToolchain
    fenixPkgs.rust-analyzer
    bacon # Background rust code checker
    cargo-info # Cargo subcommand to show crates info from crates.io
  ];
}
