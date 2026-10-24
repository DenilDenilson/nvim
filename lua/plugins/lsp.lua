return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- C / C++
      vim.lsp.config("clangd", {
        cmd = { "clangd" },
        filetypes = { "c", "h", "cpp", "hpp" },
      })

      vim.lsp.enable("clangd")

      -- Python
      vim.lsp.config("basedpyright", {
        cmd = { "basedpyright-langserver", "--stdio" },
        filetypes = { "python" },
        root_markers = {
          "pyproject.toml",
          "requirements.txt",
          ".git",
        },
      })

      vim.lsp.enable("basedpyright")
      vim.lsp.enable("ruff")
    end,
  },
}
