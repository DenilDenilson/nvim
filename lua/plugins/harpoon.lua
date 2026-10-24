return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")

      -- Obligatorio en Harpoon 2
      harpoon:setup({
        settings = {
          save_on_toggle = true,
          sync_on_ui_close = true,
        },
      })

      local map = vim.keymap.set

      -- Agregar archivo actual a Harpoon
      map("n", "<leader>a", function()
        harpoon:list():add()
      end, { desc = "Harpoon add file" })

      -- Abrir menú de Harpoon
      map("n", "<C-e>", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = "Harpoon menu" })

      -- Saltar directo a archivos marcados
      map("n", "<leader>1", function()
        harpoon:list():select(1)
      end, { desc = "Harpoon file 1" })

      map("n", "<leader>2", function()
        harpoon:list():select(2)
      end, { desc = "Harpoon file 2" })

      map("n", "<leader>3", function()
        harpoon:list():select(3)
      end, { desc = "Harpoon file 3" })

      map("n", "<leader>4", function()
        harpoon:list():select(4)
      end, { desc = "Harpoon file 4" })

      -- Moverte por la lista sin recordar números
      map("n", "<leader>hn", function()
        harpoon:list():next()
      end, { desc = "Harpoon next" })

      map("n", "<leader>hp", function()
        harpoon:list():prev()
      end, { desc = "Harpoon previous" })
    end,
  },
}
