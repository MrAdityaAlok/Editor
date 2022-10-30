-- n, v, i are mode names

local function termcodes(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

return {
  i = {
    -- go to  beginning and end
    ["<C-b>"] = { "<ESC>^i", "論 beginning of line" },
    ["<C-e>"] = { "<End>", "壟 end of line" },
    -- navigate within insert mode
    ["<C-h>"] = { "<Left>", "  move left" },
    ["<C-l>"] = { "<Right>", " move right" },
    ["<C-j>"] = { "<Down>", " move down" },
  },
  n = {
    -- switch between windows
    ["<C-h>"] = { "<C-w>h", " window left" },
    ["<C-l>"] = { "<C-w>l", " window right" },
    ["<C-j>"] = { "<C-w>j", " window down" },
    ["<C-k>"] = { "<C-w>k", " window up" },
    -- save
    ["<C-s>"] = { "<cmd> w <CR>", "save file" },
    -- Copy all
    ["<C-c>"] = { "<cmd> %y+ <CR>", "  copy whole file" },
    -- line numbers
    ["<leader>n"] = { "<cmd> set nu! <CR>", "   toggle line number" },
    ["<leader>rn"] = { "<cmd> set rnu! <CR>", "   toggle relative number" },
    -- new buffer
    ["<S-b>"] = { "<cmd> enew <CR>", "+ new buffer" },

    -- cycle through buffers
    ["<TAB>"] = { "<cmd> BufferLineCycleNext <CR>", "  cycle next buffer" },
    ["<S-Tab>"] = {
      "<cmd> BufferLineCyclePrev <CR>",
      "  cycle prev buffer",
    },
    -- LSPCONFIG
    ["gD"] = {
      function()
        vim.lsp.buf.declaration()
      end,
      "   lsp declaration",
    },
    ["gd"] = {
      function()
        vim.lsp.buf.definition()
      end,
      "   lsp definition",
    },
    ["K"] = {
      function()
        vim.lsp.buf.hover()
      end,
      "   lsp hover",
    },
    ["gi"] = {
      function()
        vim.lsp.buf.implementation()
      end,
      "   lsp implementation",
    },
    ["<leader>D"] = {
      function()
        vim.lsp.buf.type_definition()
      end,
      "   lsp definition type",
    },
    ["<leader>ra"] = {
      function()
        vim.lsp.buf.rename()
      end,
      "   lsp rename",
    },
    ["<leader>ca"] = {
      function()
        vim.lsp.buf.code_action()
      end,
      "   lsp code_action",
    },
    ["gr"] = {
      function()
        vim.lsp.buf.references()
      end,
      "   lsp references",
    },
    ["[d"] = {
      function()
        vim.diagnostic.goto_prev()
      end,
      "   goto prev",
    },
    ["d]"] = {
      function()
        vim.diagnostic.goto_next()
      end,
      "   goto_next",
    },
    ["<leader>q"] = {
      function()
        vim.diagnostic.setloclist()
      end,
      "   diagnostic setloclist",
    },
    ["<leader>fm"] = {
      function()
        vim.lsp.buf.formatting()
      end,
      "   lsp formatting",
    },
    ["<leader>wa"] = {
      function()
        vim.lsp.buf.add_workspace_folder()
      end,
      "   add workspace folder",
    },
    ["<leader>wr"] = {
      function()
        vim.lsp.buf.remove_workspace_folder()
      end,
      "   remove workspace folder",
    },
    ["<leader>wl"] = {
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      "   list workspace folders",
    },
    -- NVIMTREE
    ["<C-n>"] = { "<cmd> NvimTreeToggle <CR>", "   toggle nvimtree" },
    ["<leader>e"] = { "<cmd> NvimTreeFocus <CR>", "   focus nvimtree" },
    -- WHICK-KEY
    ["<leader>wK"] = {
      function()
        vim.cmd "WhichKey"
      end,
      "   which-key all keymaps",
    },
    ["<leader>wk"] = {
      function()
        local input = vim.fn.input "WhichKey: "
        vim.cmd("WhichKey " .. input)
      end,
      "   which-key query lookup",
    },
    -- NVTERM
    ["<A-i>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "   toggle floating term",
    },
    ["<A-h>"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "   toggle horizontal term",
    },
    ["<A-v>"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "   toggle vertical term",
    },
    ["<leader>h"] = {
      function()
        require("nvterm.terminal").new "horizontal"
      end,
      "   new horizontal term",
    },
    ["<leader>v"] = {
      function()
        require("nvterm.terminal").new "vertical"
      end,
      "   new vertical term",
    },
  },
  t = {
    ["jk"] = { termcodes "<C-\\><C-N>", "   escape terminal mode" },
    -- NVTERM
    ["<A-i>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "   toggle floating term",
    },
    ["<A-h>"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "   toggle horizontal term",
    },
    ["<A-v>"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "   toggle vertical term",
    },
  },
}
-- M.telescope = {
--   n = {
--     -- find
--     ["<leader>ff"] = { "<cmd> Telescope find_files <CR>", "  find files" },
--     ["<leader>fa"] = {
--       "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>",
--       "  find all",
--     },
--     ["<leader>fw"] = { "<cmd> Telescope live_grep <CR>", "   live grep" },
--     ["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "  find buffers" },
--     ["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "  help page" },
--     ["<leader>fo"] = {
--       "<cmd> Telescope oldfiles <CR>",
--       "   find oldfiles",
--     },
--     ["<leader>tk"] = { "<cmd> Telescope keymaps <CR>", "   show keys" },
--
--     -- git
--     ["<leader>cm"] = {
--       "<cmd> Telescope git_commits <CR>",
--       "   git commits",
--     },
--     ["<leader>gt"] = { "<cmd> Telescope git_status <CR>", "  git status" },
--
--     -- pick a hidden term
--     ["<leader>pt"] = {
--       "<cmd> Telescope terms <CR>",
--       "   pick hidden term",
--     },
--
--     -- theme switcher
--     ["<leader>th"] = { "<cmd> Telescope themes <CR>", "   nvchad themes" },
--   },
-- }
