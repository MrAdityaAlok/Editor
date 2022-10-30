local present, nvimtree = pcall(require, "nvim-tree")

if not present then
  return
end

nvimtree.setup {
  filters = {
    dotfiles = false,
  },
  disable_netrw = true,
  hijack_netrw = true,
  hijack_cursor = true,
  update_focused_file = {
    enable = true,
    update_cwd = false,
  },
  view = {
    side = "right",
    width = 30,
    hide_root_folder = true,
  },
  git = {
    enable = true,
    ignore = true, -- Use shift+h to toggle hidden files where shift+i to toggle ignored files.
  },
  actions = {
    open_file = {
      resize_window = true,
    },
  },
  renderer = {
    indent_markers = {
      enable = true,
    },
  },
}
