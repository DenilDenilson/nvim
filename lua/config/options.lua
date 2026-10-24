vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.scrolloff = 4

vim.opt.path:append("**")
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"

-- Recargar cambios externos únicamente cuando el buffer no tiene cambios locales.
vim.opt.autoread = true
local reload_group = vim.api.nvim_create_augroup("ReviewExternalChanges", { clear = true })
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "TermLeave" }, {
  group = reload_group,
  callback = function()
    -- checktime puede posponerse durante un autocmd; ejecutarlo al volver al loop.
    vim.schedule(function()
      if vim.fn.mode() ~= "c" and vim.fn.getcmdwintype() == "" then
        vim.cmd("checktime")
      end
    end)
  end,
})
