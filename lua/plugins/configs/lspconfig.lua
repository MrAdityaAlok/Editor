local function on_attach(client, bufnr)
  local autocmd = require('core.utils').autocmd

  if client.resolved_capabilities.document_formatting then
    autocmd("LspFormatting", {
      { "* <buffer>", clear = true },
      { "BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 10000)" },
    })
    vim.api.nvim_buf_set_option(bufnr, "n", "<leader>f",
      "<cmd>lua vim.lsp.buf.formatting()<cr>",
      { noremap = true, silent = false }
    )
  end

  if client.resolved_capabilities.document_highlight == true then
    autocmd("lsp_aucmds",
      { "CursorHold <buffer> lua vim.lsp.buf.document_highlight()" },
      { "CursorMoved <buffer> lua vim.lsp.buf.clear_references()" }
    )
  end

  require("core.mappings").lspconfig()
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}

local function lspSymbol(name, icon)
  local hl = "DiagnosticSign" .. name
  vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
end

lspSymbol("Error", "")
lspSymbol("Info", "")
lspSymbol("Hint", "")
lspSymbol("Warn", "")

vim.diagnostic.config {
  virtual_text = {
    prefix = "",
    source = "always",
    spacing = 4
  },
  signs = true,
  underline = true,
  update_in_insert = true,
}

-- handlers
local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "single",
  }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "single",
  })
}

-- setup lsp
local lspconfig = require("lspconfig")

for server, config in pairs(require("custom.configs.lspconfig")) do
  lspconfig[server].setup {
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      if config.on_attach then
        config.on_attach(client, bufnr)
      end
    end,
    capabilities = vim.tbl_deep_extend(
      "keep",
      config.capabilities or {},
      capabilities
    ),
    handlers = vim.tbl_deep_extend(
      "keep",
      config.handlers or {},
      handlers
    )
  }
end
