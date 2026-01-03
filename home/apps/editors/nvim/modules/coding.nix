{ pkgs
, sourceLuaFile
,
}:
{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      # Completion
      {
        plugin = nvim-cmp; # Completion engine
        config = sourceLuaFile "nvim-cmp.lua";
      }

      # {
      #   plugin = blink-cmp;
      #   config = sourceLuaFile "blink-cmp.lua";
      # }

      cmp-buffer
      cmp-dictionary
      cmp-latex-symbols
      cmp-nixpkgs-maintainers
      cmp-nvim-lsp
      cmp-path # Path completion

      # Comments
      {
        plugin = comment-nvim;
        config = sourceLuaFile "comment-nvim.lua";
      }

      # Debugging
      # {
      #   plugin = nvim-dap;
      #   config = sourceLuaFile "nvim-dap.lua";
      # }

      # Languages
      # {
      #   plugin = crates-nvim;
      #   config = sourceLuaFile "crates-nvim.lua";
      # }
      # {
      #   plugin = image-nvim;
      #   config = sourceLuaFile "image-nvim.lua";
      # }
      {
        plugin = molten-nvim;
        config = sourceLuaFile "molten-nvim.lua";
      }

      # {
      #   plugin = lazydev-nvim;
      #   config = sourceLuaFile "lazydev-nvim.lua";
      # }

      vim-nix

      {
        plugin = vimtex;
        config = sourceLuaFile "vimtex.lua";
      }

      {
        plugin = render-markdown-nvim;
        config = sourceLuaFile "render-markdown-nvim.lua";
      }

      {
        plugin = typst-preview-nvim;
        config = sourceLuaFile "typst-preview-nvim.lua";
      }

      # Linting
      # {
      #   plugin = nvim-lint;
      #   config = sourceLuaFile "nvim-lint.lua";
      # }

      {
        plugin = vim-go;
        # config = sourceLuaFile "vim-go-nvim.lua";
      }

      # Movement
      {
        plugin = multicursors-nvim;
        config = sourceLuaFile "multicursors-nvim.lua";
      }

      # Refactoring
      # {
      #   plugin = neogen;
      #   config = sourceLuaFile "neogen.lua";
      # }

      # {
      #   plugin = refactoring-nvim;
      #   config = sourceLuaFile "refactoring-nvim.lua";
      # }

      # Support for Kmonad
      {
        plugin = kmonad-vim;
        # config = sourceLuaFile "kmonad-nvim.lua";
      }

      # Snippets
      friendly-snippets # Lua snippets
      luasnip # Lua snippets engine

      # Treesitter
      nvim-treesitter-context
      nvim-treesitter-textobjects

      {
        plugin = (
          nvim-treesitter.withPlugins (p:
            builtins.attrValues (pkgs.lib.filterAttrs (_: v: pkgs.lib.isDerivation v) p)
          )
        );
        config = sourceLuaFile "nvim-treesitter.lua";
      }
    ];
  };
}
