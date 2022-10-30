-- require("tokyonight").setup({
--   style = "night",
--   transparent = true,
--   terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
--   styles = {
--     -- Style to be applied to different syntax groups
--     -- Value is any valid attr-list value for `:help nvim_set_hl`
--     comments = { italic = true },
--     keywords = { italic = true },
--     functions = { italic = true },
--     variables = {},
--     -- Background styles. Can be "dark", "transparent" or "normal"
--     sidebars = "dark", -- style for sidebars, see below
--     floats = "dark", -- style for floating windows
--   },
--   sidebars = { "qf", "help", "packer" }, -- Set a darker background on sidebar-like windows.
--   hide_inactive_statusline = true,
--   dim_inactive = true, -- dims inactive windows
--
--   --- You can override specific color groups to use other groups or a hex color
--   --- function will be called with a ColorScheme table
--   ---@param colors ColorScheme
--   on_colors = function(colors)
--     colors.bg_statusline = "NONE"
--     colors.bg_popup = "#000000"
--   end,
--
--   --- You can override specific highlights to use other groups or a hex color
--   --- function will be called with a Highlights and ColorScheme table
--   ---@param highlights Highlights
--   ---@param colors ColorScheme
--   on_highlights = function(highlights, colors)
--   end,
-- })
--

-- setup must be called before loading the colorscheme
-- Default options:
-- require("gruvbox").setup {
--   undercurl = true,
--   underline = true,
--   bold = true,
--   italic = true,
--   strikethrough = true,
--   invert_selection = false,
--   invert_signs = false,
--   invert_tabline = false,
--   invert_intend_guides = false,
--   inverse = true, -- invert background for search, diffs, statuslines and errors
--   contrast = "", -- can be "hard", "soft" or empty string
--   palette_overrides = {},
--   overrides = {},
--   dim_inactive = false,
--   transparent_mode = true,
-- }

require("catppuccin").setup {
  flavour = "mocha",
  transparent_background = true,
  term_colors = true,
  color_overrides = {
    all = {
      base = "#000000",
    },
  },
  custom_highlights = function()
    return {
      Comment = { fg = "#989898" },
      LineNr = { fg = "#606060" },
    }
  end,
  -- highlight_overrides = {
  --   mocha = function(mocha)
  --     return {
  --       NvimTreeNormal = { bg = mocha.none },
  --       CmpBorder = { fg = mocha.surface2 },
  --     }
  --   end,
  -- },
  integrations = {
    cmp = true,
    gitsigns = true,
    telescope = true,
    treesitter = true,
    treesitter_context = true,
    ts_rainbow = true,
    which_key = true,
    nvimtree = true,
  },
  native_lsp = {
    enabled = true,
    virtual_text = {
      errors = { "italic" },
      hints = { "italic" },
      warnings = { "italic" },
      information = { "italic" },
    },
    underlines = {
      errors = { "underline" },
      hints = { "underline" },
      warnings = { "underline" },
      information = { "underline" },
    },
  },
}

local cmd = vim.cmd
cmd "colorscheme catppuccin"
cmd "hi clear CursorLine"
