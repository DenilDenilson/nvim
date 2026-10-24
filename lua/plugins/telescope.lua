-- lua/plugins/telescope.lua
return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    keys = {
      {
        "<leader>ff",
        function()
          require("telescope.builtin").find_files()
        end,
        desc = "Buscar archivos",
      },
      {
        "<leader>fg",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "Buscar texto",
      },
      {
        "<leader>fb",
        function()
          require("telescope.builtin").buffers()
        end,
        desc = "Buscar buffers",
      },
      {
        "<leader>fr",
        function()
          require("telescope.builtin").oldfiles()
        end,
        desc = "Archivos recientes",
      },
      {
        "<leader>fh",
        function()
          require("telescope.builtin").help_tags()
        end,
        desc = "Buscar ayuda",
      },

      -- LSP
      {
        "<leader>fi",
        function()
          require("telescope.builtin").lsp_implementations()
        end,
        desc = "Buscar implementaciones",
      },
      {
        "<leader>fd",
        function()
          require("telescope.builtin").lsp_definitions()
        end,
        desc = "Buscar definiciones",
      },
      {
        "<leader>fR",
        function()
          require("telescope.builtin").lsp_references()
        end,
        desc = "Buscar referencias",
      },
      {
        "<leader>fs",
        function()
          require("telescope.builtin").lsp_document_symbols()
        end,
        desc = "Símbolos del archivo",
      },
      {
        "<leader>fS",
        function()
          require("telescope.builtin").lsp_dynamic_workspace_symbols()
        end,
        desc = "Símbolos del proyecto",
      },
    },
  },
}
