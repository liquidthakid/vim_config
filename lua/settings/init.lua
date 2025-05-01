require('settings/remap')
require'lspconfig'.pyright.setup{}
vim.cmd("set number")
vim.cmd("set relativenumber")

local function install_ripgrep()
  local uname = vim.loop.os_uname().sysname
  local install_cmd

  if uname == "Darwin" then
    install_cmd = "brew install ripgrep"
  elseif uname == "Linux" then
    install_cmd = "sudo apt-get install -y ripgrep"
  elseif uname:match("Windows") then
    install_cmd = "choco install ripgrep -y"
  else
    vim.notify("Unsupported OS for automatic ripgrep installation", vim.log.levels.ERROR)
    return
  end

  vim.notify("ripgrep not found. Installing...", vim.log.levels.INFO)
  vim.fn.system(install_cmd)

  if vim.fn.executable("rg") == 1 then
    vim.notify("ripgrep installed successfully!", vim.log.levels.INFO)
  else
    vim.notify("ripgrep installation failed. Please install it manually.", vim.log.levels.ERROR)
  end
end

if vim.fn.executable("rg") == 0 then
  install_ripgrep()
end
