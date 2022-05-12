local impatient = require "impatient"
--impatient.enable_profile()

local g = vim.g
-- use filetype.lua instead of filetype.vim
g.do_filetype_lua = 1
g.did_load_filetypes = 0

g.mapleader = ","

local found, _ = pcall(require, "custom.configs.filetype")
if not found then
  vim.notify(
    "Warning: failed to load custom.configs.filetype",
    vim.log.levels.WARN
  )
end

local core_modules = {
  "core.utils",
  "core.options",
  "core.autocmds",
  "core.mappings",
}

for _, module in ipairs(core_modules) do
  local ok, err = pcall(require, module)
  if not ok then
    error("Error loading " .. module .. "\n\n" .. err)
  end
end
