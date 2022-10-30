local M = {}

M.autopairs = function()
  local cmp = require "cmp"
  local autopairs = require "nvim-autopairs"
  autopairs.setup {}
  --   fast_wrap = {},
  --   disable_filetype = { "TelescopePrompt", "vim" },
  -- }
  local cmp_autopairs = require "nvim-autopairs.completion.cmp"
  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

M.blankline = function()
  local present, blankline = pcall(require, "indent_blankline")
  if not present then
    return
  end
  blankline.setup {
    indentLine_enabled = 1,
    char = "▏",
    filetype_exclude = {
      "tex",
      "help",
      "terminal",
      "alpha",
      "packer",
      "lspinfo",
      "TelescopePrompt",
      "TelescopeResults",
      "",
    },
    buftype_exclude = { "terminal" },
    show_trailing_blankline_indent = true,
    show_first_indent_level = true,
    char_highlight_list = { "Comment" },
  }
end

-- M.colorizer = function()
--   require("colorizer").setup {
--     "css",
--     "javascript",
--     html = {
--       mode = "foreground",
--     },
--   }
-- end
--
M.luasnip = function()
  local present, luasnip = pcall(require, "luasnip")
  if not present then
    return
  end
  luasnip.config.set_config {
    history = true,
    updateevents = "TextChanged,TextChangedI",
  }
  require("luasnip.loaders.from_vscode").lazy_load()
end

M.signature = function()
  local present, lsp_signature = pcall(require, "lsp_signature")
  if not present then
    return
  end
  lsp_signature.setup {
    bind = true,
    doc_lines = 0,
    floating_window = true,
    fix_pos = true,
    hint_enable = true,
    hint_prefix = " ",
    hint_scheme = "String",
    hi_parameter = "Search",
    max_height = 22,
    max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
    handler_opts = {
      border = "single", -- double, single, shadow, none
    },
    zindex = 200, -- by default it will be on top of all floating windows, set to 50 send it to bottom
    padding = "", -- character to pad on left and right of signature can be ' ', or '|'  etc
  }
end

M.gitsigns = function()
  local gitsigns = require "gitsigns"
  gitsigns.setup {}
  -- signs = { -- '│',▋
  --   add = { text = "▋", numhl = "GitSignsAddNr" },
  --   change = { text = "▋", numhl = "GitSignsChangeNr" },
  --   delete = { text = "▋", numhl = "GitSignsDeleteNr" },
  --   topdelete = { text = "▋", numhl = "GitSignsDeleteNr" },
  --   changedelete = { text = "▋", numhl = "GitSignsChangeNr" },
  -- },
end

return M
