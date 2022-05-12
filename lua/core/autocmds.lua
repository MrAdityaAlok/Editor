local autocmd = vim.api.nvim_create_autocmd
local augroup = function(name, _opts)
  local opts = _opts or { clear = true }
  vim.api.nvim_create_augroup(name, opts)
end

autocmd("BufWritePost", {
  pattern = "plugins/init.lua",
  command = "source <afile> | PackerCompile",
  desc = "Auto compile on changes to plugins/init.lua file.",
})

autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float()
  end,
})

-- autocmd({ "BufNewFile", "BufRead" }, {
--   pattern = "/dev/shm/gopass.*",
--   command = "setlocal noswapfile nobackup noundofile",
-- })
--

autocmd("BufWritePre", {
  callback = function(info)
    local bufnr = info.buf or vim.api.nvim_get_current_buf()
    vim.lsp.buf.format(
      {
        bufnr = bufnr,
        name = "null-ls", -- Only format using null_ls.
      },
      10000 -- Black takes too long to format.
    )
  end,
  group = augroup("LspFormatting", { clear = true }),
})
