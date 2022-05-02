vim.cmd "packadd packer.nvim"

local present, packer = pcall(require, "packer")

if not present then
  local packer_path = vim.fn.stdpath "data" .. "/site/pack/packer/opt/packer.nvim"

  print "Cloning packer.."
  -- remove the dir before cloning
  vim.fn.delete(packer_path, "rf")
  vim.fn.system {
    "git",
    "clone",
    "https://github.com/wbthomason/packer.nvim",
    "--depth",
    "20",
    packer_path,
  }

  vim.cmd "packadd packer.nvim"
  present, packer = pcall(require, "packer")

  if present then
    print "Packer cloned successfully."
  else
    error("Couldn't clone packer !\nPacker path: " .. packer_path .. "\n" .. packer)
  end
end

packer.init {
  -- display = {
  --   open_fn = function()
  --     return require("packer.util").float { border = "single" }
  --   end,
  --   prompt_border = "single",
  -- },
  git = {
    clone_timeout = 6000, -- seconds
  },
  auto_clean = true,
  compile_on_sync = true,
  disable_commands = true,

  -- @stale: following line is not needed now.
  -- See https://github.com/lewis6991/impatient.nvim/issues/48#issuecomment-1055281182
  -- compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua"

  -- snapshot = user_snapshot,
}

return packer
