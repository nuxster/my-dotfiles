-- Execute Vim commands
local cmd = vim.cmd
-- Global variables
local g = vim.g
-- Global/buffer/windows-scoped options
local opt = vim.opt
-- Execute Vimscript
local exec = vim.api.nvim_exec
-- Create/get autocommand group
local augroup = vim.api.nvim_create_augroup
-- Create autocommand
local autocmd = vim.api.nvim_create_autocmd

-----------------------------------------------------------
-- Translate and spelling
-----------------------------------------------------------
g.translate_source = 'en'
g.translate_target = 'ru'
opt.runtimepath:append(',~/.config/nvim/spell')

-----------------------------------------------------------
-- General
-----------------------------------------------------------
-- Rus, Eng dictionaries
opt.spelllang= { 'en_us', 'ru' }
-- Set line numbers
opt.number = true
-- Set relative numbers of line
opt.relativenumber = false
-- Enable rolling back
opt.undofile = true
opt.history = 1000
-- Vertical split to right
opt.splitright = true
-- Horizontal split to down
opt.splitbelow = true
-- Disable backup file
opt.backup = false
opt.swapfile = false
opt.writebackup = false
-- Enable mouse in all modules
opt.mouse = 'a'
-- Show paired parenthesis for [] {} and ()
opt.matchpairs = {'(:)', '{:}', '[:]', '<:>'}
-- Line ending format
opt.fileformat = 'unix'
-- File encoding
opt.encoding = 'utf-8'
-- System clipboard
opt.clipboard = 'unnamedplus'

-----------------------------------------------------------
-- UI
-----------------------------------------------------------
-- 24-bit RGB colors
opt.termguicolors = true
-- Set color scheme
cmd'colorscheme onedark'
-- Show vim mode
opt.showmode = true
-- Shom CMD
opt.showcmd = true
-- Set colorcolumn (vertical line after 80 chars)
augroup('setColorColumn', {
    clear = true
})

autocmd('Filetype', {
  group = 'setColorColumn',
  pattern = {'python', 'sh', 'c', 'cpp', 'js', 'xml', 'yml'},
  command = 'set colorcolumn=80 nowrap'
})
-- Highlighting a line with cursor
opt.cursorline = true

-----------------------------------------------------------
-- Tab
-----------------------------------------------------------
cmd([[
filetype indent plugin on
syntax enable
]])
-- Use spaces instead of tabs
opt.expandtab = true
-- Shift 2 spaces when tab
opt.shiftwidth = 2
-- 1 tab == 2 spaces
opt.tabstop = 2
-- Autoindent new lines
opt.smartindent = true
-- Don't auto commenting new lines
cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]
-- Remove line lenght marker for selected filetypes
cmd [[autocmd FileType text,markdown,html,xhtml,javascript setlocal cc=0]]
-- 2 spaces for selected filetypes
cmd [[
autocmd FileType xml,html,xhtml,css,scss,javascript,lua,yaml,yml,htmljinja setlocal shiftwidth=2 tabstop=2
]]
-- For html file with jinja2
cmd[[ autocmd BufNewFile,BufRead *.html set filetype=htmldjango ]]

-----------------------------------------------------------
-- Useful things
-----------------------------------------------------------
-- Remembers where nvim last edited the file
cmd [[
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]]
-- Highlights the copied part of the text for a fraction of a second
exec([[
augroup YankHighlight
autocmd!
autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
augroup end
]], false)
-- Remove whitespace on save
autocmd('BufWritePre', {
    pattern = '',
    command = ":%s/\\s\\+$//e"
})
-- Don't auto commenting new lines
autocmd('BufEnter', {
    pattern = '',
    command = 'set fo-=c fo-=r fo-=o'
})

-----------------------------------------------------------
-- Plugins
-----------------------------------------------------------
-- disable netrw at the very start of your init.lua (strongly advised)
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
opt.termguicolors = true

-- OR setup with some options
-- require('nvim-tree').setup({
--   sort_by = 'case_sensitive',
--   view = {
--     adaptive_size = false,
--     width = 50,
--     -- mappings = {
--     --   list = {
--     --     { key = "u", action = "dir_up" },
--     --   },
--     -- },
--   },
--   renderer = {
--     group_empty = true,
--   },
--   filters = {
--     dotfiles = true,
--   },
-- })

-- Status bar
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '|', right = '|'},
    section_separators = { left = '', right = ''},
   },
}

-- Buffers/tabs
opt.termguicolors = true
require('bufferline').setup{
  options = {
    hover = {
      enabled = true,
      delay = 200,
      reveal = {'close'}
    },
    numbers = function(opts)
      return string.format('%s', opts.raise(opts.ordinal))
    end,
  },
}

-- Minimap
require('codewindow').setup{
    auto_enable = true,
    show_cursor = false,
    minimap_width = 20,
    exclude_filetypes = { 'dashboard', 'help' },
    window_border = 'none',
}

-- Terminal
require('neoterm').setup({
  -- run clear command before user specified commands
  clear_on_run = true,
  -- vertical/horizontal/fullscreen
  mode = 'horizontal',
  -- disable entering insert mode when opening the neoterm window
  noinsert = false
})

-- SSHFS
-- require("sshfs").setup {
-- 	mnt_base_dir = vim.fn.expand("$HOME") .. "/mnt",
-- 	width = 0.6, -- host window width
-- 	height = 0.5, -- host window height
-- 	connection_icon = "✓", -- icon for connection indication
-- }

-----------------------------------------------------------
-- Development
-----------------------------------------------------------
--  Indentation guides
local highlight = {
    "CursorColumn",
    "Whitespace",
}
require("ibl").setup {
    indent = { highlight = highlight, char = "" },
    whitespace = {
        highlight = highlight,
        remove_blankline_trail = false,
    },
    scope = { enabled = false },
}

-- Highlight, edit, and navigate code using a fast incremental parsing library
require('nvim-treesitter.configs').setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = {"python", "c", "bash", "yaml"},
  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,
  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,
  -- List of parsers to ignore installing (or "all")
  -- ignore_install = { "javascript" },
  highlight = {
    enable = true,
    -- disable = { "fish", "lua", "txt" },
    additional_vim_regex_highlighting = false,
  },
}

-- LSP settings
-- :LspInstall <lsname>
local servers = {
  "lua_ls",
  "marksman",
  "pylsp",
  "terraformls",
  "lemminx"
}

-- local servers = {
--   "sumneko_lua",
--   "bashls",
--   "dockerls",
--   "html",
--   "jsonls",
--   "tsserver",
--   "marksman",
--   "sqlls",
--   "pylsp",
--   "terraformls",
--   "lemminx",
--   "yamlls"
-- }

require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

require("mason-lspconfig").setup({
  ensure_installed = servers,
  automatic_installation = true
})

-- Add additional capabilities supported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require('lspconfig')

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    -- on_attach = my_custom_on_attach,
    capabilities = capabilities
  }
end

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
    if cmp.visible() then
        cmp.select_next_item()
    elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
    else
        fallback()
    end
    end, {'i', 's'}),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
    if cmp.visible() then
        cmp.select_prev_item()
    elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
    else
        fallback()
    end
    end, {'i', 's'})
    }),
    sources = {{
      name = 'nvim_lsp'
    }, {
      name = 'luasnip'
    }, {
      name = 'path'
    }, {
      name = 'buffer',
      option = {
        -- Avoid accidentally running on big files
        get_bufnrs = function()
          local buf = vim.api.nvim_get_current_buf()
          local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
          if byte_size > 1024 * 1024 then -- 1 Megabyte max
            return {}
          end
          return {buf}
        end
      }
    }}
}

