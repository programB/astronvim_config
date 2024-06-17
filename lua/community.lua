-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.project.nvim-spectre" }, -- powerful search/replace
  { import = "astrocommunity.editing-support.neogen" }, -- annotation generator (for classes, functions, etc.)
  { import = "astrocommunity.motion.flash-nvim" }, -- powerful plugin for jumping inside a file
  { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },
  -- import/override with your plugins folder
}
