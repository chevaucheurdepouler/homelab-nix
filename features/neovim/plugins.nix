{
  lib,
  config,
  pkgs,
  ...
}:
{
  programs.nixvim = {
    plugins = {
      lsp = {
        enable = true;
        servers = {
          asm_lsp.enable = true;
          gopls.enable = true;
          java_language_server.enable = true;
          rust-analyzer.enable = true;
        };
      };

      nvim-cmp = {
        enable = true;
        autoEnableSources = true;
        sources = [
          { name = "nvim_lsp"; }
          { name = "path"; }
          { name = "buffer"; }

        ];
      };
      barbar.enable = true;
      gitsigns.enable = true;

      comment = {
        enable = true;
      };

      treesitter = {
        enable = true;
      };

      web-devicons = {
        enable = true;
      };

      emmet = {
        enable = true;
      };

      nvim-autopairs = {
        enable = true;
      };

      presence-nvim = {
        enable = true;
      };

      chadtree = {
        enable = true;
      };

      fzf-lua = {
        enable = true;
      };

      notify = true;

      neotest = {
        enable = true;
        adapters = {
          rust.enable = true;
          python.enable = true;
          java.enable = true;
          go.enable = true;
        };
      };
    };
  };
}
