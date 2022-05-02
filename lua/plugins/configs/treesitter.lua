local present, treesitter = pcall(require, "nvim-treesitter.configs")

if not present then
  return
end

treesitter.setup {
  ensure_installed = {
    "lua",
    "vim",
    "bash",
    "c",
    "comment",
    "cpp",
    "css",
    "go",
    "html",
    "java",
    "javascript",
    "jsonc",
    "python",
    "kotlin",
    "regex",
    "rust",
    "toml",
    "typescript",
    "yaml",
    "ruby",
    "haskell",
    "cmake",
    "make",
    "ninja",
  },
  highlight = {
    enable = true,
    use_languagetree = true,
  },
  autopairs = { enable = true },
  context_commentstring = { enable = true },
  rainbow = { enable = true, extended_mode = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}
