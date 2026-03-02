{ inputs, nixCats }:
let
  inherit (nixCats) utils;

  luaPath = ./.;

  extra_pkg_config = {
    # allowUnfree = true;
  };

  dependencyOverlays = [
    # This overlay grabs all the inputs named in the format
    # `plugins-<pluginName>`
    # Once we add this overlay to our nixpkgs, we are able to
    # use `pkgs.neovimPlugins`, which is a set of our plugins.
    (utils.standardPluginOverlay inputs)
  ];

  # see :help nixCats.flake.outputs.categories
  # and
  # :help nixCats.flake.outputs.categoryDefinitions.scheme
  categoryDefinitions =
    { pkgs, settings, categories, extra, name, mkPlugin, ... }@packageDef:
    {
      lspsAndRuntimeDeps = with pkgs; {
        general = [
          universal-ctags
          ripgrep
          fd
          stdenv.cc.cc
          nix-doc
          lua-language-server
          tree-sitter
          nixd
          stylua
        ];
        kickstart-debug = [
          delve
        ];
        kickstart-lint = [
          markdownlint-cli
        ];
      };

      startupPlugins = with pkgs.vimPlugins; {
        general = [
          vim-sleuth
          lazy-nvim
          comment-nvim
          gitsigns-nvim
          which-key-nvim
          telescope-nvim
          telescope-fzf-native-nvim
          telescope-ui-select-nvim
          nvim-web-devicons
          plenary-nvim
          nvim-lspconfig
          lazydev-nvim
          fidget-nvim
          conform-nvim
          nvim-cmp
          luasnip
          cmp_luasnip
          cmp-nvim-lsp
          cmp-path
          tokyonight-nvim
          todo-comments-nvim
          mini-nvim
          nvim-treesitter.withAllGrammars
        ];
        kickstart-debug = [
          nvim-dap
          nvim-dap-ui
          nvim-dap-go
          nvim-nio
        ];
        kickstart-indent_line = [
          indent-blankline-nvim
        ];
        kickstart-lint = [
          nvim-lint
        ];
        kickstart-autopairs = [
          nvim-autopairs
        ];
        kickstart-neo-tree = [
          neo-tree-nvim
          nui-nvim
          nvim-web-devicons
          plenary-nvim
        ];
      };

      optionalPlugins = {};

      sharedLibraries = {
        general = with pkgs; [
          # libgit2
        ];
      };

      environmentVariables = {
        test = {
          CATTESTVAR = "It worked!";
        };
      };

      extraWrapperArgs = {
        test = [
          '' --set CATTESTVAR2 "It worked again!"''
        ];
      };

      python3.libraries = {
        test = (_: [ ]);
      };

      extraLuaPackages = {
        test = [ (_: [ ]) ];
      };
    };

  # see :help nixCats.flake.outputs.packageDefinitions
  packageDefinitions = {
    nvim = { pkgs, name, ... }: {
      settings = {
        suffix-path = true;
        suffix-LD = true;
        wrapRc = true;
        aliases = [ "vim" ];
        hosts.python3.enable = true;
        hosts.node.enable = true;
      };

      categories = {
        general = true;
        gitPlugins = true;
        customPlugins = true;
        test = true;

        kickstart-autopairs = true;
        kickstart-neo-tree = true;
        kickstart-debug = true;
        kickstart-lint = true;
        kickstart-indent_line = true;

        kickstart-gitsigns = true;

        have_nerd_font = false;

        example = {
          youCan = "add more than just booleans";
          toThisSet = [
            "and the contents of this categories set"
            "will be accessible to your lua with"
            "nixCats('path.to.value')"
            "see :help nixCats"
            "and type :NixCats to see the categories set in nvim"
          ];
        };
      };
    };
  };

  defaultPackageName = "nvim";
in
{
  inherit
    luaPath
    extra_pkg_config
    dependencyOverlays
    categoryDefinitions
    packageDefinitions
    defaultPackageName
    ;
}
