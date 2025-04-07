-- Installs and configures gruvbox-material colorscheme plugin (https://github.com/sainnhe/gruvbox-material)
-- following an example in the AstroNvim documentation (https://docs.astronvim.com/recipes/colorscheme/
return {
  {
    "AstroNvim/astroui",
    ---@type AstroUIOpts
    opts = {
      colorscheme = "gruvbox-material",
    },
  },
  {
    -- Best colortheme ever
    "sainnhe/gruvbox-material",
    init = function() -- init function runs before the plugin is loaded
      vim.g.gruvbox_material_background = "soft" -- "soft", "medium"(default), "hard"
    end,
  },
}
