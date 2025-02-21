--[[ Standart Neovim settings ]]

--[[ Unknown options:
  vim.g.did_load_filetypes = 1
  vim.g.formatoptions = "qrn1"
  vim.opt.showmode = false
  vim.opt.updatetime = 100
  vim.wo.linebreak = true
  vim.opt.virtualedit = "block"
  vim.opt.undofile = true
  vim.cmd("highlight clear LineNr")
  vim.cmd("highlight clear SignColumn")

  -- Splits
  vim.opt.splitbelow = true
  vim.opt.splitright = true

  -- Shorter messages
  vim.opt.shortmess:append("c")
--]]



--[[ Editor ]]
vim.opt.wrap = false
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.smartindent = true
vim.opt.fileformat = 'dos'
vim.wo.cursorline = true

vim.opt.list = true
vim.opt.listchars = {
  space = '⋅',
}

--vim.g.vim_markdown_fenced_languages = {'c', 'python'}

--[[ Search ]]
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.smartcase = true

--[[ Sidebar ]]
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 3
-- Statusline, borders
vim.wo.signcolumn = "yes" -- additional first column for LSP mark, sign, etc.
vim.opt.fillchars = {
    -- vert = "│",
    -- fold = "⠀",
    -- eob = " ", -- suppress ~ at EndOfBuffer
    -- diff = "⣿", -- alternatives = ⣿ ░ ─ ╱
    -- msgsep = "‾",
    -- foldopen = "▾"
    -- foldsep = "│",
    -- foldclose = "▸"
}


--[[ Environment ]]
-- Mouse
vim.opt.mouse = "a"
vim.opt.mousefocus = true
-- Clipboard
-- vim.opt.clipboard = "unnamedplus"

