---@param opts PluginLspOpts
return function(_, opts)
  local Util = require("util")
  -- setup autoformat
  require("plugins.lsp.format").setup(opts)
  -- setup formatting and keymaps
  Util.on_attach(function(client, buffer)
    require("plugins.lsp.keymaps").on_attach(client, buffer)
  end)

  --------------------- diagnostics -----------------------------
  local diagnostic_icons = require("config").icons.diagnostics

  for name, icon in pairs(diagnostic_icons) do
    name = "DiagnosticSign" .. name
    vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
  end

  if opts.inlay_hints.enabled and vim.lsp.buf.inlay_hint then
    Util.on_attach(function(client, buffer)
      if client.server_capabilities.inlayHintProvider then
        vim.lsp.buf.inlay_hint(buffer, true)
      end
    end)
  end

  if opts.diagnostics.virtual_text.prefix == "icons" then
    opts.diagnostics.virtual_text.prefix = function(diagnostic)
      for d, icon in pairs(diagnostic_icons) do
        if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
          return icon
        end
      end
    end

    vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

    ----------------------- Server setup ---------------------
    local capabilities = vim.tbl_deep_extend("force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      require("cmp_nvim_lsp").default_capabilities(),
      opts.capabilities
    )

    for server, server_opts in pairs(opts.servers) do
      server_opts = vim.tbl_deep_extend("force",
        { capabilities = capabilities },
        server_opts
      )
      if opts.setup[server] then
        if opts.setup[server](server, server_opts) then
          return
        end
      elseif opts.setup["*"] then
        if opts.setup["*"](server, server_opts) then
          return
        end
      end
      require("lspconfig")[server].setup(server_opts)
    end
  end
  -- if Util.lsp_get_config("denols") and Util.lsp_get_config("tsserver") then
  --         local is_deno = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")
  --         Util.lsp_disable("tsserver", is_deno)
  --         Util.lsp_disable("denols", function(root_dir)
  --           return not is_deno(root_dir)
  --         end)
  --       end
  --     end,
  --   },
  --
end
