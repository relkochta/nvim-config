local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- lazy.nvim configuration
local plugins_dir = "plugins"
local opts = {
  -- disable change detection because it's annoying
  change_detection = {
    enabled = false,
    notify = false,
  },
}

require("lazy").setup(plugins_dir, opts)
