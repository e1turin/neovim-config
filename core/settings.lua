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



--[[ Lines ]]
vim.opt.wrap = false
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.smartindent = true
-- Sidebar
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 5
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

