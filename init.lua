require "impatient"

require "custom.configs.filetype"

vim.g.mapleader = ","

local core_modules = {
  "core.utils",
  "core.options",
  "core.autocmds",
  "core.mappings",
  "core.commands",
}

for _, module in ipairs(core_modules) do
  local ok, err = pcall(require, module)
  if not ok then
    error("Error loading " .. module .. "\n\n" .. err)
  end
end
