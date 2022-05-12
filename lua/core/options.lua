local opt = vim.opt

opt.confirm = true
opt.laststatus = 3 -- global statusline
opt.clipboard = "unnamedplus"
opt.cmdheight = 1
opt.cul = true -- cursor line

-- Indentline
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true

-- disable tilde on end of buffer: https://github.com/neovim/neovim/pull/8546#issuecomment-643643758
opt.fillchars = { eob = " " }

opt.hidden = true
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"

-- Numbers
opt.number = true
opt.numberwidth = 2
opt.ruler = false

-- disable nvim intro
opt.shortmess:append "sI"

opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.tabstop = 2
opt.softtabstop = 0
opt.termguicolors = true
opt.undofile = true
-- Let it be higher since using fix updatetime plugin.
opt.updatetime = 500
-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"

opt.lazyredraw = true

-- disable some builtin vim plugins

local default_plugins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "matchit",
  "tar",
  "tarPlugin",
  "rrhelper",
  "spellfile_plugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
}

for i = 1, 18 do -- XXX: Hard coded. Update if number changes.
  vim.g["loaded_" .. default_plugins[i]] = 1
end

vim.schedule(function()
  vim.opt.shadafile = vim.fn.stdpath "cache" .. "/nvim_shada"
  vim.cmd [[ silent! rsh ]]
end)
