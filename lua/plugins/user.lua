-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  {
    -- Plugin for fast toggling booleans and other 2-state values
    -- (added to search/replace menu created by the Spectre plugin)
    -- (shortcut <Leader>sb)
    "gerazov/toggle-bool.nvim",
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = function(_, opts)
          local maps = opts.mappings
          local prefix = "<Leader>s"
          maps.n[prefix .. "b"] = { function() require("toggle-bool").toggle_bool() end, desc = "Toggle boolean" }
        end,
      },
    },
    config = function()
      require("toggle-bool").setup {
        -- The toggles included by default are:
        -- False ←→ True
        -- false ←→ true
        additional_toggles = {
          Yes = "No",
          On = "Off",
          ["0"] = "1",
          Enable = "Disable",
          Enabled = "Disabled",
          First = "Last",
          Before = "After",
          Persistent = "Ephemeral",
          Internal = "External",
          Ingress = "Egress",
          Allow = "Deny",
          All = "None",
          any = "all",
        },
      }
    end,
  },

  {
    -- Plugin for visualising merge conflicts
    "akinsho/git-conflict.nvim",
    version = "*",
    config = function()
      require("git-conflict").setup {
        -- default_mappings = true,
        default_mappings = false, -- disable buffer local mapping created by this plugin
        default_commands = true,
        -- default_commands = false,     -- disable commands created by this plugin
        disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
        highlights = {
          -- They must have background color, otherwise the default color will be used
          incoming = "DiffAdd",
          current = "DiffText",
        },
      }
    end,
  },

  -- == Examples of Overriding Plugins ==

  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        " █████  ███████ ████████ ██████   ██████",
        "██   ██ ██         ██    ██   ██ ██    ██",
        "███████ ███████    ██    ██████  ██    ██",
        "██   ██      ██    ██    ██   ██ ██    ██",
        "██   ██ ███████    ██    ██   ██  ██████",
        " ",
        "    ███    ██ ██    ██ ██ ███    ███",
        "    ████   ██ ██    ██ ██ ████  ████",
        "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
        "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
        "    ██   ████   ████   ██ ██      ██",
      }
      return opts
    end,
  },

  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = false },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },
  {
    -- move git symbols and icons to the left side of the gutter
    "rebelot/heirline.nvim",
    optional = true,
    opts = function(_, opts)
      local status = require "astroui.status"
      -- opts.statusline = nil -- no, do not hide statusline
      -- opts.statuscolumn = vim.fn.has "nvim-0.9" == 1
      opts.statuscolumn = vim.fn.has "nvim-0.9" == 1
          and {
            status.component.foldcolumn(),
            status.component.signcolumn(),
            status.component.numbercolumn(),
          }
        or nil
    end,
  },
  {
    -- show git status in the gutter for new files (not yet tracked in git repo)
    "lewis6991/gitsigns.nvim",
    -- (extend/amend opts table for this plugin)
    opts = {
      attach_to_untracked = true,
      signs = {
        -- use a distinct sign for untracked lines
        untracked = { text = "┆" },
      },
    },
  },
  {
    -- set code annotation style for python
    "danymat/neogen",
    opts = function(_, opts)
      -- do not override the opts languages table - extend it
      return require("astrocore").extend_tbl(opts, {
        languages = { python = { template = { annotation_convention = "reST" } } }, -- "google_docstrings","numpydoc", "reST"
      })
    end,
  },
}
