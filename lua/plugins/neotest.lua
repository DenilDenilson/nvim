return {
  {
    "nvim-neotest/neotest",

    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-python",
    },

    config = function()
      local neotest = require("neotest")

      neotest.setup({
        adapters = {
          require("neotest-python")({
            runner = "pytest",

            python = function()
              local venv = vim.fn.getcwd() .. "/.venv/bin/python"

              if vim.fn.executable(venv) == 1 then
                return venv
              end

              return vim.fn.exepath("python")
            end,
          }),
        },

        summary = {
          open = "topleft vsplit | vertical resize 40",
        },

        output_panel = {
          open = "botright split | resize 15",
        },
      })
    end,
  },
}
