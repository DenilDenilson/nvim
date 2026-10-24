return {
  {
    "nvim-neotest/neotest",
    keys = {
      { "<leader>tt", function() require("neotest").run.run() end, desc = "Ejecutar test cercano" },
      { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Tests del archivo" },
      { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Panel de tests" },
      { "<leader>to", function() require("neotest").output_panel.toggle() end, desc = "Salida de tests" },
      { "<leader>tS", function() require("neotest").run.stop() end, desc = "Detener tests" },
    },

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
