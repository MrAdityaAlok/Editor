local present, treesitter = pcall(require, "nvim-treesitter.configs")

if not present then
  return
end

treesitter.setup {
  ensure_installed = {
    -- Nvim related:
    "vim",
    "lua",

    -- Core languages:
    "c",
    "cpp",
    "rust",
    "go",
    "python",
    "java",
    "kotlin",
    "haskell",
    "ruby",

    -- Web development languages (minimal):
    "css",
    "html",
    "javascript",
    "typescript",
    --
    "jsonc",

    -- Scripting languages:
    "bash",
    "fish",
    "perl",
    "regex",
    "toml",
    "yaml",

    -- Build systems:
    "cmake",
    "make",
    "meson",
    "ninja",

    -- Miscelleneous:
    "comment",
    "diff",
    "gitignore",
    "gitattributes",

    ---
    "markdown",
    "markdown_inline",
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
