local map = vim.api.nvim_set_keymap
local set = vim.keymap.set
local default_opts = {noremap = true, silent = false}

local opts = { noremap = true, silent = true }

-- Remap space as leader key
-- map("", "<Space>", "<Nop>", opts)
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = " "

--------------
-- F1 - F12 --
--------------
-- <F1> Clean the last search backlight
map('n', '<F1>', ':nohl<CR>', default_opts)

-- <F2> Re-read vim configuration
map('n', '<F2>', ':so ~/.config/nvim/init.lua<CR>:so ~/.config/nvim/lua/plugins.lua<CR>:so ~/.config/nvim/lua/settings.lua<CR>:so ~/.config/nvim/lua/keymaps.lua<CR>', { noremap = true })

-- <F3> Change line numbering method
map('n', '<F3>', ':exec &nu==&rnu? "se nu!" : "se rnu!"<CR>', default_opts)

-- <F7> Terminals
map('n', '<F7>', ':NeotermToggle<CR>', {})
-- map('t', '<F7>', [[<C-\><C-n><CR>:NeotermToggle<CR>]], {})
map('t', '<F7>', [[<C-\><C-n>:NeotermToggle<CR>]], {})

-- <F8> Minimap
set ('n', '<F8>', function () require('codewindow').toggle_minimap() end)

-- <F11> Spell check for Russian and English
map('n', '<F11>', ':set spell!<CR>', default_opts)
map('i', '<F11>', '<C-O>:set spell!<CR>', default_opts)

-- <12> Open file system manager
-- map('n', '<F12>', ':NvimTreeRefresh<CR>:NvimTreeToggle<CR>', default_opts)
map('n', '<F12>', ':Neotree toggle<CR>', default_opts)

--------------
-- Other    --
--------------
-- <t> Translate Eng -> Rus
map('v', 't', '<Plug>(VTranslate)', {})
-- <Ctrl+t> Translate Rus -> Eng
map('v', '<C-t>', ':Translate!<CR>', default_opts)

-- <Tab> Select next buffer
map('n', '<Tab>', ':BufferLineCycleNext<CR>', default_opts)
-- <Shift+Tab> Select previos buffer
map('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', default_opts)

-- <Ctrl+m> Markdown preview toggle
map('n', '<C-m>', '<Plug>MarkdownPreviewToggle', {})

