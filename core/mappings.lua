vim.g.mapleader = "<Space>"

-- https://github.com/ibhagwan/nvim-lua/blob/82daba2fd86fd388bc61dedb49126fb7cb12ccae/lua/keymaps.lua
local map = vim.keymap.set
-- Navigate buffers
map("n", "[b", ":bprevious<CR>", { desc = "Previous buffer" })
map("n", "]b", ":bnext<CR>", { desc = "Next buffer" })
map("n", "[B", ":bfirst<CR>", { desc = "First buffer" })
map("n", "]B", ":blast<CR>", { desc = "Last buffer" })

map("n", "<leader>", function () print("kek") end)

