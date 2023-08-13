require("config").init()

return {
  {
    "folke/lazy.nvim",
    version = "*",
    opts = {
      checker = { enabled = false },
      change_detection = { enabled = false }
    }
  },
}
