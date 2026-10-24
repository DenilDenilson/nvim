return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    cmd = "Neotree",
    keys = {
      { "<leader>e", "<cmd>Neotree filesystem reveal toggle left<cr>", desc = "Árbol del proyecto" },
      { "<leader>ge", "<cmd>Neotree git_status toggle left<cr>", desc = "Árbol de cambios Git" },
    },
    opts = {
      close_if_last_window = true,
      window = { position = "left", width = 32 },
      filesystem = {
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
        filtered_items = { hide_dotfiles = false },
      },
    },
  },
}
