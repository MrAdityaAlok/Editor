local autocmd = require "core.utils".autocmd
-- uncomment this if you want to open nvim with a dir
-- vim.cmd [[ autocmd BufEnter * if &buftype != "terminal" | lcd %:p:h | endif ]]

-- Use relative & absolute line numbers in 'n' & 'i' modes respectively
-- vim.cmd[[ au InsertEnter * set norelativenumber ]]
-- vim.cmd[[ au InsertLeave * set relativenumber ]]

autocmd("misc_aucmds", {
  { -- Auto compile on changes to plugins/init.lua file.
    "BufWritePost plugins/init.lua source <afile> | PackerCompile", clear = true
  },
  -- { "FileType smali set commentstring=#\\ %s", clear = true },
  {
    -- Open a file from its last left off position
    [[ BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif ]]
  },
  { "CursorHold * lua vim.diagnostic.open_float()", clear = true },
  { "BufNewFile,BufRead /dev/shm/gopass.* setlocal noswapfile nobackup noundofile", clear = true }
})

-- When cursorline is set, highlight only line number
autocmd("CLClear", "ColorScheme * hi clear CursorLine")

-- File extension specific tabbing
-- vim.cmd [[ autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4 ]]
