local present, feline = pcall(require, "feline")

if not present then
  return
end

local lsp = require "feline.providers.lsp"
local lsp_severity = vim.diagnostic.severity

local icon_styles = {
  default = {
    left = "",
    right = " ",
    main_icon = "  ",
    vi_mode_icon = " ",
    position_icon = " ",
  },
  arrow = {
    left = "",
    right = "",
    main_icon = "  ",
    vi_mode_icon = " ",
    position_icon = " ",
  },

  block = {
    left = " ",
    right = " ",
    main_icon = "   ",
    vi_mode_icon = "  ",
    position_icon = "  ",
  },

  round = {
    left = "",
    right = "",
    main_icon = "  ",
    vi_mode_icon = " ",
    position_icon = " ",
  },

  slant = {
    left = " ",
    right = " ",
    main_icon = "  ",
    vi_mode_icon = " ",
    position_icon = " ",
  },
}

local separator_style = icon_styles["round"]

-- Initialize the components table
local components = {
  active = {},
}

local main_icon = {
  provider = separator_style.main_icon,
  right_sep = {
    str = separator_style.right,
  },
}

local file_name = {
  provider = function()
    local filename = vim.fn.expand "%:t"
    local extension = vim.fn.expand "%:e"
    local icon = require("nvim-web-devicons").get_icon(filename, extension)
    if icon == nil then
      icon = " "
      return icon
    end
    return " " .. icon .. " " .. filename .. " "
  end,
  right_sep = {
    str = separator_style.right,
  },
}

local dir_name = {
  provider = function()
    local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
    return "  " .. dir_name .. " "
  end,
  right_sep = {
    str = separator_style.right,
  },
}

local diff = {
  add = {
    provider = "git_diff_added",
    icon = " ",
  },

  change = {
    provider = "git_diff_changed",
    icon = "  ",
  },

  remove = {
    provider = "git_diff_removed",
    icon = "  ",
  },
}

local git_branch = {
  provider = "git_branch",
  icon = "  ",
}

local diagnostic = {
  error = {
    provider = "diagnostic_errors",
    enabled = function()
      return lsp.diagnostics_exist(lsp_severity.ERROR)
    end,
    icon = "  ",
  },

  warning = {
    provider = "diagnostic_warnings",
    enabled = function()
      return lsp.diagnostics_exist(lsp_severity.WARN)
    end,
    icon = "  ",
  },

  hint = {
    provider = "diagnostic_hints",
    enabled = function()
      return lsp.diagnostics_exist(lsp_severity.HINT)
    end,
    icon = "  ",
  },

  info = {
    provider = "diagnostic_info",
    enabled = function()
      return lsp.diagnostics_exist(lsp_severity.INFO)
    end,
    icon = "  ",
  },
}

local lsp_progress = {
  provider = function()
    local Lsp = vim.lsp.util.get_progress_messages()[1]

    if Lsp then
      local msg = Lsp.message or ""
      local percentage = Lsp.percentage or 0
      local title = Lsp.title or ""
      local spinners = { "", "", "" }
      local success_icon = { "", "", "" }

      local ms = vim.loop.hrtime() / 1000000
      local frame = math.floor(ms / 120) % #spinners

      if percentage >= 70 then
        return string.format(" %%<%s %s %s (%s%%%%) ", success_icon[frame + 1], title, msg, percentage)
      end
      return string.format(" %%<%s %s %s (%s%%%%) ", spinners[frame + 1], title, msg, percentage)
    end
    return ""
  end,
}

local lsp_icon = {
  provider = function()
    if next(vim.lsp.buf_get_clients()) ~= nil then
      return "  LSP"
    else
      return ""
    end
  end,
}

local empty_space = {
  provider = " " .. separator_style.left,
}

-- this matches the vi mode color
local empty_spaceColored = {
  provider = separator_style.left,
}

local mode_icon = {
  provider = separator_style.vi_mode_icon,
}

local empty_space2 = {
  provider = function()
    local modes = {
      ["n"] = "NORMAL",
      ["no"] = "N-PENDING",
      ["i"] = "INSERT",
      ["ic"] = "INSERT",
      ["t"] = "TERMINAL",
      ["v"] = "VISUAL",
      ["V"] = "V-LINE",
      [""] = "V-BLOCK",
      ["R"] = "REPLACE",
      ["Rv"] = "V-REPLACE",
      ["s"] = "SELECT",
      ["S"] = "S-LINE",
      ["c"] = "COMMAND",
      ["cv"] = "COMMAND",
      ["ce"] = "COMMAND",
      ["r"] = "PROMPT",
      ["rm"] = "MORE",
      ["r?"] = "CONFIRM",
      ["!"] = "SHELL",
    }
    return " " .. modes[vim.fn.mode()] .. " "
  end,
}

local separator_right = {
  provider = separator_style.left,
}

local separator_right2 = {
  provider = separator_style.left,
}

local position_icon = {
  provider = separator_style.position_icon,
}

local current_line = {
  provider = function()
    local current_line = vim.fn.line "."
    local total_line = vim.fn.line "$"

    if current_line == 1 then
      return " Top "
    elseif current_line == vim.fn.line "$" then
      return " Bot "
    end
    local result, _ = math.modf((current_line / total_line) * 100)
    return " " .. result .. "%% "
  end,
}

local function add_table(a, b)
  table.insert(a, b)
end

-- components are divided in 3 sections
local left = {}
local middle = {}
local right = {}

-- left
add_table(left, main_icon)
add_table(left, file_name)
add_table(left, dir_name)
add_table(left, diff.add)
add_table(left, diff.change)
add_table(left, diff.remove)
add_table(left, diagnostic.error)
add_table(left, diagnostic.warning)
add_table(left, diagnostic.hint)
add_table(left, diagnostic.info)
add_table(left, {
  provider = function()
    local found, gps = pcall(require, "nvim-gps")
    if found and gps.is_available then
      return gps.get_location
    end
    return ""
  end,
})

add_table(middle, lsp_progress)

-- right
add_table(right, lsp_icon)
add_table(right, git_branch)
add_table(right, empty_space)
add_table(right, empty_spaceColored)
add_table(right, mode_icon)
add_table(right, empty_space2)
add_table(right, separator_right)
add_table(right, separator_right2)
add_table(right, position_icon)
add_table(right, current_line)

components.active[1] = left
components.active[2] = middle
components.active[3] = right

feline.setup {
  -- TODO: theme =
  components = components,
}
