return {
  {
    "sindrets/diffview.nvim",
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Revisar cambios Git" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Historial del archivo" },
      { "<leader>gq", "<cmd>DiffviewClose<cr>", desc = "Cerrar revisión" },
      { "<leader>gr", "<cmd>DiffviewRefresh<cr>", desc = "Refrescar diff" },
    },
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewFileHistory",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
      "DiffviewRefresh",
    },
  },
}
