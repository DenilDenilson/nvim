local map = vim.keymap.set

-- Buffers
map("n", "<leader>bb", "<cmd>ls<cr>:b ", { desc = "Cambiar buffer" })
map("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Buffer siguiente" })
map("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Buffer anterior" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Cerrar buffer" })
map("n", "<leader><leader>", "<C-^>", { desc = "Último buffer" })


-- Splits
map("n", "<leader>sv", "<cmd>vsplit<cr>", { desc = "Split vertical" })
map("n", "<leader>sh", "<cmd>split<cr>", { desc = "Split horizontal" })
map("n", "<leader>se", "<C-w>=", { desc = "Igualar splits" })
map("n", "<leader>sx", "<cmd>close<cr>", { desc = "Cerrar split" })

-- Navegación entre tabs
map("n", "<A-,>", "gT", { desc = "Tab anterior" })
map("n", "<A-.>", "gt", { desc = "Tab siguiente" })

map("t", "<A-,>", "<C-\\><C-n>gT", { desc = "Tab anterior" })
map("t", "<A-.>", "<C-\\><C-n>gt", { desc = "Tab siguiente" })

-- Ir directamente a tabs 1-4
for i = 1, 4 do
  map("n", "<A-" .. i .. ">", i .. "gt", {
    desc = "Ir a tab " .. i,
  })

  map("t", "<A-" .. i .. ">", "<C-\\><C-n>" .. i .. "gt", {
    desc = "Ir a tab " .. i,
  })
end

-- Essentials
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Guardar" })
map("n", "<leader>q", "<cmd>q<cr>", { desc = "Salir" })
map("n", "<leader>x", "<cmd>x<cr>", { desc = "Guardar y salir" })

map("n", "<leader>e", "<cmd>Ex<cr>", { desc = "Explorer" })

map("n", "<leader>cf", function()
  require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "Format" })

map("n", "gD", vim.lsp.buf.declaration, { desc = "Ir a declaración" })
map("n", "gd", vim.lsp.buf.definition, { desc = "Ir a definición" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Ir a implementación" })
map("n", "gt", vim.lsp.buf.type_definition, { desc = "Ir a tipo" })
map("n", "gr", vim.lsp.buf.references, { desc = "Referencias" })

map("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Diagnostic float" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

-- Salir de Terminal Mode
map("t", "<C-g>", "<C-\\><C-n>", { desc = "Salir de terminal mode" })

-- Navegar entre ventanas desde Terminal Mode
map("t", "<C-h>", "<C-\\><C-n><C-w>h", {
  desc = "Ventana izquierda",
})

map("t", "<C-j>", "<C-\\><C-n><C-w>j", {
  desc = "Ventana abajo",
})

map("t", "<C-k>", "<C-\\><C-n><C-w>k", {
  desc = "Ventana arriba",
})

map("t", "<C-l>", "<C-\\><C-n><C-w>l", {
  desc = "Ventana derecha",
})
