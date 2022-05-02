local present, packer = pcall(require, "plugins.packerInit")

if not present then
  return false
end

local plugins = {
  ["lewis6991/impatient.nvim"] = {},
  ["nvim-lua/plenary.nvim"] = {},

  ["wbthomason/packer.nvim"] = {
    event = "VimEnter",
  },

  -- ["NvChad/nvim-base16.lua"] = {
  --   after = "packer.nvim",
  --   config = function()
  --     require("colors").init()
  --   end,
  -- },

  ["NvChad/nvterm"] = {
    config = function()
      require "plugins.configs.nvterm"
    end,
  },

  ["kyazdani42/nvim-web-devicons"] = {
    --TODO: after = "nvim-base16.lua",
  },

  ["feline-nvim/feline.nvim"] = {
    after = "nvim-web-devicons",
    config = function()
      require "plugins.configs.statusline"
    end,
  },

  ["akinsho/bufferline.nvim"] = {
    after = "nvim-web-devicons",
    setup = function()
      require("core.mappings").bufferline()
    end,
    config = function()
      require "plugins.configs.bufferline"
    end,
  },

  ["lukas-reineke/indent-blankline.nvim"] = {
    event = "BufRead",
    config = function()
      require("plugins.configs.others").blankline()
    end,
  },

  ["NvChad/nvim-colorizer.lua"] = function()
    local ft = {
      "css",
      "javascript",
      "vim",
      "html",
      "lua",
      "jproperties",
      "properties",
    }
    return {
      event = "BufRead",
      ft = ft,
      config = require("plugins.configs.others").colorizer(ft),
    }
  end,

  ["nvim-treesitter/nvim-treesitter"] = {
    event = { "BufRead", "BufNewFile" },
    run = ":TSUpdate",
    config = function()
      require "plugins.configs.treesitter"
    end,
  },
  ["JoosepAlviste/nvim-ts-context-commentstring"] = {
    after = "nvim-treesitter",
  },
  ["p00f/nvim-ts-rainbow"] = { after = "nvim-ts-context-commentstring" },
  ["SmiteshP/nvim-gps"] = {
    after = "nvim-ts-rainbow",
    config = function()
      require("nvim-gps").setup()
    end,
  },

  -- git stuff
  ["lewis6991/gitsigns.nvim"] = {
    opt = true,
    config = function()
      require("plugins.configs.others").gitsigns()
    end,
    setup = function()
      require("core.utils").packer_lazy_load "gitsigns.nvim"
    end,
  },

  -- lsp stuff
  ["b0o/schemastore.nvim"] = {
    module = "lspconfig",
    before = "nvim-lspconfig",
    setup = function()
      require("core.utils").packer_lazy_load "schemastore.nvim"
    end,
  },
  ["neovim/nvim-lspconfig"] = {
    module = "lspconfig",
    opt = true,
    setup = function()
      require("core.utils").packer_lazy_load "nvim-lspconfig"
      -- reload the current file so lsp actually starts for it
      vim.defer_fn(function()
        vim.cmd 'if &ft == "packer" | echo "" | else | silent! e %'
      end, 0)
    end,
    config = function()
      require "plugins.configs.lspconfig"
    end,
  },
  ["jose-elias-alvarez/null-ls.nvim"] = {
    config = function()
      require "plugins.configs.null_ls"
    end,
    after = "nvim-lspconfig",
  },

  -- ["ray-x/lsp_signature.nvim"] = {
  --   after = "nvim-lspconfig",
  --   config = function()
  --     require("plugins.configs.others").signature()
  --   end,
  -- },
  --
  ["numToStr/Comment.nvim"] = {
    module = "Comment",
    keys = { "gc", "gb" },
    setup = function()
      require("core.mappings").comment()
    end,
    config = function()
      require("Comment").setup()
    end,
  },

  ["andymass/vim-matchup"] = {
    opt = true,
    setup = function()
      require("core.utils").packer_lazy_load "vim-matchup"
    end,
  },

  ["max397574/better-escape.nvim"] = {
    event = "InsertCharPre",
    config = function()
      require("plugins.configs.others").better_escape()
    end,
  },

  -- load luasnips + cmp related in insert mode only

  ["rafamadriz/friendly-snippets"] = {
    module = "cmp_nvim_lsp",
    event = "InsertEnter",
  },

  ["hrsh7th/nvim-cmp"] = {
    after = "friendly-snippets",
    config = function()
      require "plugins.configs.cmp"
    end,
  },

  ["L3MON4D3/LuaSnip"] = {
    wants = "friendly-snippets",
    after = "nvim-cmp",
    config = function()
      require("plugins.configs.others").luasnip()
    end,
  },

  ["saadparwaiz1/cmp_luasnip"] = {
    after = "LuaSnip",
  },
  ["hrsh7th/cmp-nvim-lua"] = {
    after = "cmp_luasnip",
  },
  ["hrsh7th/cmp-nvim-lsp"] = {
    after = "cmp-nvim-lua",
  },
  ["hrsh7th/cmp-buffer"] = {
    after = "cmp-nvim-lsp",
  },
  ["hrsh7th/cmp-path"] = {
    after = "cmp-buffer",
  },
  ["petertriho/cmp-git"] = {
    after = "cmp-path",
    setup = function()
      require("cmp_git").setup()
    end,
  },

  -- misc plugins
  ["windwp/nvim-autopairs"] = {
    after = "nvim-cmp",
    config = function()
      require("plugins.configs.others").autopairs()
    end,
  },
  ["antoinemadec/FixCursorHold.nvim"] = {
    opt = true,
    setup = function()
      vim.g.cursorhold_updatetime = 100
      require("utils").packer_lazy_load "FixCursorHold.nvim"
    end,
  },
  ["goolord/alpha-nvim"] = {
    disable = true,
    config = function()
      require "plugins.configs.alpha"
    end,
  },
  ["folke/which-key.nvim"] = {
    event = "BufEnter",
    config = function()
      require("which-key").setup()
    end,
  },

  -- file managing , picker etc
  ["kyazdani42/nvim-tree.lua"] = {
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    setup = function()
      require("core.mappings").nvimtree()
    end,
    config = function()
      require "plugins.configs.nvimtree"
    end,
  },

  -- Additional syntax highlightings
  ["MrAdityaAlok/vim-smali"] = { ft = "smali" },
  ["tpope/vim-git"] = { ft = { "gitcommit", "gitrebase" }, opt = true },

  -- Smooth scrolling
  ["karb94/neoscroll.nvim"] = {
    event = "WinScrolled",
    config = function()
      require("neoscroll").setup {
        hide_cursor = false,
        respect_scrolloff = true,
        easing_function = "sine",
      }
    end,
  },

  -- ["nvim-telescope/telescope.nvim"] = {
  --   cmd = "Telescope",
  --   setup = function()
  --     require("core.mappings").telescope()
  --   end,
  --   config = function()
  --     require "plugins.configs.telescope"
  --   end,
  -- },
}

return packer.startup(function(use)
  for _, v in pairs(plugins) do
    if type(v) == "function" then
      v = v()
    end
    use(v)
  end
end)
