local present, wk = pcall(require, "which-key")

if not present then
  return
end

local options = {
  spelling = {
    enable = true,
  },
}

local mappings = require "core.mappings"
-- register mappings
for k, v in pairs(mappings) do
  wk.register(v, { mode = k })
end
wk.setup(options)
