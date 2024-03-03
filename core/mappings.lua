--[[ Additional keyboard mappings ]]

vim.g.mapleader = ' ' -- space for <leader> key

-- https://github.com/ibhagwan/nvim-lua/blob/82daba2fd86fd388bc61dedb49126fb7cb12ccae/lua/keymaps.lua
local map = vim.keymap.set

-- [[ Navigation ]]
-- Navigate windows
-- Terminal Mode
map('t', '<A-h>', '<C-\\><C-N><C-w>h')
map('t', '<A-j>', '<C-\\><C-N><C-w>j')
map('t', '<A-k>', '<C-\\><C-N><C-w>k')
map('t', '<A-l>', '<C-\\><C-N><C-w>l')
-- Insert Mode
map('i', '<A-h>', '<C-\\><C-N><C-w>h')
map('i', '<A-j>', '<C-\\><C-N><C-w>j')
map('i', '<A-k>', '<C-\\><C-N><C-w>k')
map('i', '<A-l>', '<C-\\><C-N><C-w>l')
-- Normal Mode
map('n', '<A-h>', '<C-w>h')
map('n', '<A-j>', '<C-w>j')
map('n', '<A-k>', '<C-w>k')
map('n', '<A-l>', '<C-w>l')
-- Navigate buffers
map('n', '[b', ':bprevious<CR>', { desc = 'Previous buffer' })
map('n', ']b', ':bnext<CR>', { desc = 'Next buffer' })
map('n', '[B', ':bfirst<CR>', { desc = 'First buffer' })
map('n', ']B', ':blast<CR>', { desc = 'Last buffer' })

-- [[ OS Interaction ]]
map('v', '<C-c>', '"+y', { desc = 'Copy to system clipboard' })
map('i', '<C-v>', '<C-o>"+p', { desc = 'Paste from system clipboard' })
map('i', '<C-a>', '<Esc>ggVG', { desc = 'Select all content (enter Insert mode before)' })
-- map('v', '<C-a>', 'ggoG', { desc = 'Select all content (enter Visual mode before)' A}) -- troubles with 'increment numbers in selection'
map('t', '<Esc>', '<C-\\><C-N>', { desc = 'Exit to Normal Mode from Terminal emulator mode' })
map('v', '<C-A-l>', 'gq', { desc = 'Use default format command with IntelliJ shortcut' })
-- Show directory tree
map('n', '<leader>d', function ()
  require('nvim-tree.api').tree.focus()
end , { desc = 'Focus on directory tree window' })

-- [[ Vim Fix ]]
vim.cmd([[let g:ftplugin_sql_omni_key = '<C-\>']]) -- remove noisy completion in SQL



