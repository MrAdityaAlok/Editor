local M = {}

local cmd = vim.cmd

M.map = function(mode, keys, command, opt)
  local options = { noremap = true, silent = true }

  if opt then
    options = vim.tbl_extend("force", options, opt)
  end

  if type(keys) == "table" then
    for _, keymap in ipairs(keys) do
      M.map(mode, keymap, command, opt)
    end
    return
  end

  vim.keymap.set(mode, keys, command, opt)
end

-- load plugin after entering vim ui
M.packer_lazy_load = function(plugin, timer)
  if plugin then
    timer = timer or 0
    vim.defer_fn(function()
      require("packer").loader(plugin)
    end, timer)
  end
end

-- Highlights functions

-- Define bg color
-- @param group Group
-- @param color Color

M.bg = function(group, col)
  cmd("hi " .. group .. " guibg=" .. col)
end

-- Define fg color
-- @param group Group
-- @param color Color
M.fg = function(group, col)
  cmd("hi " .. group .. " guifg=" .. col)
end

-- Define bg and fg color
-- @param group Group
-- @param fgcol Fg Color
-- @param bgcol Bg Color
M.fg_bg = function(group, fgcol, bgcol)
  cmd("hi " .. group .. " guifg=" .. fgcol .. " guibg=" .. bgcol)
end

function M.autocmd(group, cmds)
  cmd("augroup " .. group)
  if type(cmds) == "string" then
    cmds = { cmds, clear = false }
  end
  for _, _cmd in ipairs(cmds) do
    if type(_cmd) == "string" then -- if cmds contains single entry like { cmd, clear = true }
      cmd(string.format("%s %s", cmds["clear"] and "autocmd!" or "autocmd", _cmd))
    else
      --[[ if cmds contains multiple enteries like:
       {
         { cmd1, clear = <bool>},
         {cmd2, clear = <bool>}
       }
      --]]
      cmd(string.format("%s %s", _cmd["clear"] and "autocmd!" or "autocmd", _cmd[1]))
    end
  end
  cmd("augroup END")
end

return M
