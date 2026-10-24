-- Run from ~/.config/nvim: nvim --headless '+lua dofile("tests/review.lua")'
local ok, err = xpcall(function()
  assert(vim.v.errmsg == "", vim.v.errmsg)
  for _, file in ipairs(vim.fn.glob("lua/**/*.lua", false, true)) do
    assert(loadfile(file))
  end
  for _, key in ipairs({ " e", " ge", " gd", " gh", " gq", " gr", " gg", " tt", " tf", " ts", " to", " tS", " wq" }) do
    assert(vim.fn.maparg(key, "n") ~= "", "Missing mapping: " .. key)
  end
  assert(vim.fn.maparg(" x", "n") == "", "Old exit mapping conflicts with Trouble")
  print("PASS: Lua syntax and review mappings")

  vim.cmd("edit lua/config/options.lua")
  assert(vim.wait(5000, function()
    return vim.b.gitsigns_head ~= nil and vim.fn.maparg(" gp", "n") ~= ""
  end), "Gitsigns did not attach")
  assert(vim.fn.maparg("]c", "n") ~= "")
  assert(vim.fn.maparg(" gp", "n") ~= "")
  print("PASS: Gitsigns attaches to tracked files")

  vim.cmd("Neotree filesystem reveal left")
  assert(vim.bo.filetype == "neo-tree", "Tree did not open")
  vim.cmd("Neotree close")
  vim.cmd("Neotree git_status left")
  assert(vim.bo.filetype == "neo-tree", "Git tree did not open")
  vim.cmd("Neotree close")
  print("PASS: filesystem and Git trees")

  vim.cmd("DiffviewOpen")
  assert(vim.wait(5000, function() return require("diffview.lib").get_current_view() ~= nil end))
  vim.cmd("DiffviewRefresh")
  vim.cmd("DiffviewClose")
  print("PASS: Diffview open, refresh, close")

  local neotest = require("neotest")
  neotest.summary.toggle()
  neotest.summary.toggle()
  neotest.output_panel.toggle()
  neotest.output_panel.toggle()
  print("PASS: Neotest panels")

  local path = vim.fn.tempname()
  vim.fn.writefile({ "original" }, path)
  vim.cmd.edit(path)
  vim.fn.writefile({ "external change, different length" }, path)
  local timestamp = os.time() + 2
  assert(vim.uv.fs_utime(path, timestamp, timestamp))
  vim.api.nvim_exec_autocmds("FocusGained", {})
  assert(vim.wait(2000, function()
    return vim.api.nvim_get_current_line() == "external change, different length"
  end), "External change not reloaded")
  vim.api.nvim_buf_set_lines(0, 0, -1, false, { "unsaved local change" })
  vim.fn.writefile({ "another external change" }, path)
  assert(vim.uv.fs_utime(path, timestamp + 2, timestamp + 2))
  vim.api.nvim_exec_autocmds("FocusGained", {})
  local drained = false
  vim.schedule(function() drained = true end)
  assert(vim.wait(2000, function() return drained end))
  assert(vim.api.nvim_get_current_line() == "unsaved local change", "Local edit was overwritten")
  assert(vim.bo.modified, "Local edit no longer marked modified")
  vim.cmd("bdelete!")
  vim.fn.delete(path)
  print("PASS: external reload preserves unsaved edits")
  assert(vim.v.errmsg == "", vim.v.errmsg)
end, debug.traceback)
if not ok then
  vim.api.nvim_err_writeln(err)
  vim.cmd("cquit 1")
else
  print("PASS: review smoke tests")
  vim.cmd("qa!")
end
