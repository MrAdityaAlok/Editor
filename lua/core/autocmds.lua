local autocmd = vim.api.nvim_create_autocmd

local augroup = function(name, _opts)
  local opts = _opts or { clear = true }
  vim.api.nvim_create_augroup(name, opts)
end

autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float()
  end,
})

-- autocmd("User LuasnipChoiceNodeEnter", {
--   callback = function()
--     -- vim.keymap.set({ "i", "s" }, "<c-u>", function()
--     require "luasnip.extras.select_choice"()
--     -- end)
--   end,
-- })

autocmd({ "BufNewFile", "BufReadPre" }, {
  pattern = "secret",
  callback = function()
    vim.cmd "setlocal noswapfile nobackup noundofile"
    vim.cmd.echo '"INFO: Secret mode active."'
  end,
})

autocmd("BufWritePre", {
  callback = function(info)
    local bufnr = info.buf or vim.api.nvim_get_current_buf()
    vim.lsp.buf.format {
      bufnr = bufnr,
      name = "null-ls", -- Only format using null_ls.
      timeout_ms = 10000, -- Black, perltidy takes too long to format.
    }
  end,
  group = augroup("LspFormatting", { clear = true }),
})
