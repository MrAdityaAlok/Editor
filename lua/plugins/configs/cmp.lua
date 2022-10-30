local cmp = require "cmp"

local default_sources = {
  { name = "nvim_lsp" },
  { name = "nvim_lsp_signature_help" },
  { name = "luasnip_choice" },
  { name = "luasnip" },
  { name = "path" },
  { name = "buffer" },
}

cmp.setup {
  view = {
    entries = { name = "custom", selection_order = "near_cursor" },
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ["<CR>"] = cmp.mapping.confirm {
      select = true,
      behavior = cmp.ConfirmBehavior.Replace,
    },
    ["<C-j>"] = cmp.mapping.scroll_docs(-4),
    ["<C-l>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = {
      c = cmp.mapping.close(),
      i = cmp.mapping.abort(),
    },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif require("luasnip").expand_or_locally_jumpable() then
        require("luasnip").expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  formatting = {
    format = function(entry, vim_item)
      local icons = require "custom.configs.lspkind_icons"
      vim_item.kind =
        string.format("%s %s", icons[vim_item.kind], vim_item.kind)
      -- set a name for each source
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        nvim_lua = "[Lua]",
        luasnip = "[LuaSnip]",
        luasnip_choice = "[LuaSnip(choice)]",
        git = "[GIT]",
        path = "[Path]",
        buffer = "[BUF]",
        fish = "[Fish]",
        nvim_lsp_signature_help = "[Signature]",
        nvim_lsp_document_symbol = "[DocSymbol]",
      })[entry.source.name]

      return vim_item
    end,
  },
  sources = default_sources,
}

cmp.setup.filetype({ "gitcommit", "gitrebase" }, {
  sources = cmp.config.sources { { name = "git" }, { name = "buffer" } },
})

cmp.setup.filetype("fish", {
  sources = cmp.config.sources({
    { name = "fish" },
    { name = "luasnip" },
  }, { { name = "buffer" } }),
})

cmp.setup.filetype("lua", {
  sources = cmp.config.sources {
    { name = "nvim_lua" },
    unpack(default_sources),
  },
})

cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources {
    { name = "buffer" },
    { name = "nvim_lsp_document_symbol" },
  },
})
