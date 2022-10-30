local present, packer = pcall(require, "plugins.packerInit")
if not present then
  return false
end

local plugins = {
  { "lewis6991/impatient.nvim" },
  { "nvim-lua/plenary.nvim" },
  {
    "catppuccin/nvim",
    as = "catppuccin",
    run = ":CatppuccinCompile",
    config = function()
      require "custom.configs.theme"
    end,
  },

  { "wbthomason/packer.nvim", event = "VimEnter" },
  -- {
  --   "j-hui/fidget.nvim",
  --   config = function()
  --     require("fidget").setup()
  --   end,
  -- },

  -- {
  --   "folke/noice.nvim",
  --   event = "VimEnter",
  --   config = function()
  --     require "plugins.configs.noice"
  --   end,
  --   requires = {
  --     -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
  --     "MunifTanjim/nui.nvim",
  --     "rcarriga/nvim-notify",
  --   },
  -- },
  --
  -- {
  --   "NvChad/nvterm",
  --   config = function()
  --     require "plugins.configs.nvterm"
  --   end,
  -- },

  { "kyazdani42/nvim-web-devicons", after = "catppuccin" },

  {
    "feline-nvim/feline.nvim",
    after = "catppuccin",
    config = function()
      local ctp_feline = require "catppuccin.groups.integrations.feline"

      require("feline").setup {
        components = ctp_feline.get(),
      }

      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
          package.loaded["feline"] = nil
          package.loaded["catppuccin.groups.integrations.feline"] = nil
          require("feline").setup {
            components = require("catppuccin.groups.integrations.feline").get(),
          }
        end,
      })
    end,
  },

  -- {
  --   "akinsho/bufferline.nvim",
  --   after = "nvim-web-devicons",
  --   config = function()
  --     require "plugins.configs.bufferline"
  --   end,
  -- },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    config = function()
      require("plugins.configs.others").blankline()
    end,
  },

  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   event = "BufRead",
  --   config = require("plugins.configs.others").colorizer(),
  -- },
  --
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufRead", "BufNewFile" },
    run = ":TSUpdate",
    config = function()
      require "plugins.configs.treesitter"
    end,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    after = "nvim-treesitter",
  },
  { "p00f/nvim-ts-rainbow", after = "nvim-ts-context-commentstring" },
  { "nvim-treesitter/nvim-treesitter-context", after = "nvim-ts-rainbow" },

  -- git stuff
  {
    "lewis6991/gitsigns.nvim",
    opt = true,
    config = function()
      require("plugins.configs.others").gitsigns()
    end,
    setup = function()
      __my_utils.packer_lazy_load "gitsigns.nvim"
    end,
  },

  -- lsp stuff
  -- {
  --   "b0o/schemastore.nvim",
  --   opt = true,
  -- },
  {
    "neovim/nvim-lspconfig",
    -- module = "schemastore",
    opt = true,
    setup = function()
      __my_utils.packer_lazy_load "nvim-lspconfig"
      -- reload the current file so lsp actually starts for it
      vim.defer_fn(function()
        vim.cmd 'if &ft == "packer" | echo "" | else | silent! e %'
      end, 0)
    end,
    config = function()
      require "plugins.configs.lspconfig"
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      require "plugins.configs.null_ls"
    end,
    after = "nvim-lspconfig",
  },

  -- {"ray-x/lsp_signature.nvim",
  --   after = "nvim-lspconfig",
  --   config = function()
  --     require("plugins.configs.others").signature()
  --   end,
  -- },
  --
  {
    "numToStr/Comment.nvim",
    module = "Comment",
    keys = { "gc", "gb" },
    config = function()
      require("Comment").setup()
    end,
  },

  {
    "andymass/vim-matchup",
    opt = true,
    setup = function()
      __my_utils.packer_lazy_load "vim-matchup"
    end,
  },

  -- {
  --   "max397574/better-escape.nvim",
  --   event = "InsertCharPre",
  --   config = function()
  --     require("plugins.configs.others").better_escape()
  --   end,
  -- },
  --
  -- load luasnips + cmp related in insert mode only

  {
    "rafamadriz/friendly-snippets",
    module = "cmp_nvim_lsp",
    event = "InsertEnter",
  },

  {
    "hrsh7th/nvim-cmp",
    after = "friendly-snippets",
    config = function()
      require "plugins.configs.cmp"
    end,
  },

  {
    "L3MON4D3/LuaSnip",
    wants = "friendly-snippets",
    after = "nvim-cmp",
    config = function()
      require("plugins.configs.others").luasnip()
    end,
  },

  { "saadparwaiz1/cmp_luasnip", after = "LuaSnip" },
  { "hrsh7th/cmp-nvim-lua", after = "cmp_luasnip" },
  { "hrsh7th/cmp-nvim-lsp", after = "cmp-nvim-lua" },
  { "hrsh7th/cmp-buffer", after = "cmp-nvim-lsp" },
  { "hrsh7th/cmp-path", after = "cmp-buffer" },
  { "hrsh7th/cmp-nvim-lsp-document-symbol", after = "cmp-path" },
  {
    "hrsh7th/cmp-nvim-lsp-signature-help",
    after = "cmp-nvim-lsp-document-symbol",
  },
  {
    "doxnit/cmp-luasnip-choice",
    after = "cmp-nvim-lsp-signature-help",
    config = function()
      require("cmp_luasnip_choice").setup()
    end,
  },
  {
    "petertriho/cmp-git",
    ft = { "gitcommit", "gitrebase" },
    config = function()
      require("cmp_git").setup()
    end,
  },
  { "mtoohey31/cmp-fish", ft = "fish" },

  -- misc plugins
  {
    "windwp/nvim-autopairs",
    after = "nvim-cmp",
    config = function()
      require("plugins.configs.others").autopairs()
    end,
  },
  {
    "antoinemadec/FixCursorHold.nvim",
    opt = true,
    setup = function()
      vim.g.cursorhold_updatetime = 100
      __my_utils.packer_lazy_load "FixCursorHold.nvim"
    end,
  },
  {
    "goolord/alpha-nvim",
    disable = true,
    config = function()
      require "plugins.configs.alpha"
    end,
  },
  {
    "folke/which-key.nvim",
    event = "BufEnter",
    config = function()
      require "plugins.configs.whichkey"
    end,
  },

  -- file managing , picker etc
  {
    "kyazdani42/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    config = function()
      require "plugins.configs.nvimtree"
    end,
  },

  -- Additional syntax highlightings
  -- {"icedman/nvim-textmate", config= function()
  --   require "plugins.configs.textmate"
  -- end
  -- },
  { "MrAdityaAlok/vim-smali", ft = "smali" },
  {
    "nvim-neorg/neorg",
    cmd = "Neorg",
    run = ":Neorg sync-parsers",
    ft = "norg",
    after = "nvim-treesitter",
    config = function()
      require "plugins.configs.neorg"
    end,
    requires = "nvim-lua/plenary.nvim",
  },
  -- { "tpope/vim-git", ft = { "gitcommit", "gitrebase" } },
  -- using packer.nvim
  {
    "nmac427/guess-indent.nvim",
    event = "BufEnter",
    config = function()
      require("guess-indent").setup {}
    end,
  },

  -- Smooth scrolling
  {
    "karb94/neoscroll.nvim",
    event = "WinScrolled",
    config = function()
      require("neoscroll").setup {
        hide_cursor = false,
        respect_scrolloff = true,
        easing_function = "sine",
      }
    end,
  },

  -- { "stevearc/dressing.nvim", event = "BufEnter" },

  -- {"nvim-telescope/telescope.nvim",
  --   cmd = "Telescope",
  --   config = function()
  --     require "plugins.configs.telescope"
  --   end,
  -- },
}

return packer.startup(function(use)
  for i = 1, #plugins do
    use(plugins[i])
  end
end)
