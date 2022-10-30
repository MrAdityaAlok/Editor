local function on_attach(client, _)
  local autocmd = vim.api.nvim_create_autocmd

  if client.server_capabilities.document_highlight == true then
    autocmd("CursorHold <buffer>", {
      callback = function()
        vim.lsp.buf.document_highlight()
      end,
    })
    autocmd("CursorMoved <buffer>", {
      callback = function()
        vim.lsp.buf.clear_references()
      end,
    })
  end
end

local function lspSymbol(name, icon)
  local hl = "DiagnosticSign" .. name
  vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
end

lspSymbol("Error", "")
lspSymbol("Info", "")
lspSymbol("Hint", "")
lspSymbol("Warn", "")

vim.diagnostic.config {
  virtual_text = function()
    if vim.api.nvim_get_mode()["mode"] == "i" then
      return {
        prefix = "",
        source = "always",
        spacing = 4,
      }
    else
      return false
    end
  end,
  signs = true,
  underline = true,
  update_in_insert = true,
}

-- handlers
local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  }),
}

vim.diagnostic.config { float = { border = "rounded" } }

-- setup lsp
local lspconfig = require "lspconfig"

local capabilities = require("cmp_nvim_lsp").default_capabilities()

for server, config in pairs(require "custom.configs.lspconfig") do
  if type(config) == "function" then
    config = config()
  end
  config.on_attach = on_attach
  config.capabilities =
    vim.tbl_deep_extend("keep", config.capabilities or {}, capabilities)
  config.handlers = vim.tbl_deep_extend("keep", config.handlers or {}, handlers)
  lspconfig[server].setup(config)
end
