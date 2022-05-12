_G.__my_utils = {}

__my_utils.map = function(mode, keys, command, opt)
  local options = { noremap = true, silent = true }

  if opt then
    options = vim.tbl_extend("force", options, opt)
  end

  if type(keys) == "table" then
    for _, keymap in ipairs(keys) do
      __my_utils.map(mode, keymap, command, opt)
    end
    return
  end

  vim.keymap.set(mode, keys, command, opt)
end

-- load plugin after entering vim ui
__my_utils.packer_lazy_load = function(plugin, timer)
  if plugin then
    timer = timer or 0
    vim.defer_fn(function()
      require("packer").loader(plugin)
    end, timer)
  end
end
