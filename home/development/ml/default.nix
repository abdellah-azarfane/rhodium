{ config
, lib
, pkgs
, ...
}:
with lib;
let
  pkgIf = name: lib.optionals (builtins.hasAttr name pkgs) [ pkgs.${name} ];
in
{
  options = {
    programs.development.ml = {
      enable = mkEnableOption "ML development tools";
    };
  };
  config = mkIf config.programs.development.ml.enable {
    home.packages = [
      # --- AI Agent Frameworks ---
      pkgs.autogen # Framework for building autonomous AI agents

      # --- Data Versioning ---
      pkgs.dvc # Git for data, models, and pipelines

      # --- Language Models ---
      pkgs.llama-cpp # C/C++ implementation of LLaMA model inference
      pkgs.ollama # Run large language models locally

      # --- Model Tools ---
      # --- NLP Frameworks ---

      # --- Speech Recognition ---
      pkgs.whisper-cpp # Low-resource C++ port of OpenAI's Whisper

      # --- Vector Databases ---
      pkgs.qdrant # Vector database management for semantic search
    ]
    # Optional packages (may live in overlays or be removed/renamed in nixpkgs)
    ++ pkgIf "text-generation-webui"
    ++ pkgIf "ggml-tools"
    ++ pkgIf "huggingface-cli"
    ++ pkgIf "haystack"
    ++ pkgIf "comfyui"
    ++ pkgIf "milvus";
  };
}
