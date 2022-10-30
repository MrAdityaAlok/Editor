local null_ls = require "null-ls"
null_ls.setup {
  -- update_in_insert = true,
  diagnostics_format = "[#{c}] #{m} (#{s})",
  sources = {
    null_ls.builtins.formatting.perltidy.with {
      extra_args = { "-i=2" },
    },
    null_ls.builtins.formatting.clang_format,
    null_ls.builtins.formatting.rustfmt,
    null_ls.builtins.formatting.trim_whitespace,
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.formatting.shfmt.with {
      filetypes = { "sh", "bash" },
      extra_args = {
        "--space-redirects",
        "--binary-next-line",
        "--case-indent",
      },
    },
    null_ls.builtins.formatting.isort,
    null_ls.builtins.formatting.black.with {
      args = {
        "--quiet",
        "--line-length=80",
        "--experimental-string-processing",
        "-",
      },
    },
    null_ls.builtins.formatting.stylua.with {
      extra_args = {
        "--column-width=80",
        "--indent-type=Spaces",
        "--indent-width=2",
        "--quote-style=AutoPreferDouble",
        "--call-parentheses=None",
      },
    },
    null_ls.builtins.formatting.gofmt,
    -- null_ls.builtins.diagnostics.write_good,
    -- null_ls.builtins.code_actions.gitsigns,
  },
}

-- shellcheck shared config
-- null_ls.register {
--   filetypes = { "sh", "bash" },
--   args = {
--     "--format",
--     "json1",
--     "--external-sources",
--     "--enable=all",
--     "--source-path=$DIRNAME",
--     "-a",
--     "-",
--   },
--   sources = {
--     null_ls.builtins.code_actions.shellcheck,
--     null_ls.builtins.diagnostics.shellcheck,
--   },
-- }
