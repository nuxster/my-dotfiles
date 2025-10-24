vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- Packer
  use 'wbthomason/packer.nvim'

  -----------------------------------------------------------
  -- General plugins
  -----------------------------------------------------------
  -- File system manager
  -- use {
  --   'nvim-tree/nvim-tree.lua',
  --   requires = {
  --     'nvim-tree/nvim-web-devicons',
  --   },
  -- }

  use {
    'nvim-neo-tree/neo-tree.nvim',
    branch = "v3.x",
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
      -- '3rd/image.nvim', -- Optional image support in preview window: See `# Preview Mode` for more information
    }
  }

  -- List, select and switch between buffers
  -- <Leader>b  - (typically: \b) to open a window listing all buffers
  -- <C-V>      - to edit the selected buffer in a new vertical split
  -- <C-S>      - to edit the selected buffer in a new horizontal split
  -- <C-T>      - to edit the selected buffer in a new tab page
  -- ]b         - to next buffer
  -- b[         - to previous bufer
  use 'jeetsukumaran/vim-buffergator'

  -- Terminal
  use 'itmecho/neoterm.nvim'

  -- Minimap
  use {'gorbit99/codewindow.nvim',
    config = function()
      local codewindow = require('codewindow')
      codewindow.setup()
      codewindow.apply_default_keybinds()
    end,
  }

  -- Scrollbar
  use 'dstein64/nvim-scrollview'

  -- Status bar
  use {'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  -- Buffers/tabs
  use {'akinsho/bufferline.nvim', tag = "v3.*",
    requires = 'nvim-tree/nvim-web-devicons'
  }

  -- SSHFS
  -- use 'DanielWeidinger/nvim-sshfs'

  -- use {'chipsenkbeil/distant.nvim',
  --   branch = 'v0.3',
  --   config = function(c
  --     require('distant'):setup()
  --   end
  -- }

  -----------------------------------------------------------
  -- Plugins for GUI
  -----------------------------------------------------------
  -- Color scheme
  use 'joshdick/onedark.vim'

  -- popup windows
  use 'nvim-lua/popup.nvim'

  -----------------------------------------------------------
  -- etc
  -----------------------------------------------------------
  -- Even if the Russian vim layout is enabled, the commands will work
  use 'powerman/vim-plugin-ruscmd'

  -- Plugin lets you deal with pairs of things (surrounding things)
  -- vS'      - in visualmode
  -- ysiw'    - surround one word
  -- yss'     - surround line
  -- ds'      - delete surrounds
  -- dstdst   - delete surround tags
  -- cs"'     - change surrounds
  -- cst<tag> - change surrounds tags
  use 'tpope/vim-surround'

  -- Code comments
  -- gcc               - comment line
  -- gc in visual mode - comment select block
  use 'tomtom/tcomment_vim'

  -- Multiple cursors
  -- Ctrl-n  - select words
  -- q       - skip current and get next occurrence
  use 'mg979/vim-visual-multi'

  -- Closes paired parenthesis for [] {} and ()
  use 'cohama/lexima.vim'

  -- Counts the number of matches in the search
  use 'google/vim-searchindex'

  -- Vim start page
  use 'mhinz/vim-startify'

  -- Translate rus,eng
  use 'skanehira/translate.vim'


  -----------------------------------------------------------
  -- Programming
  -----------------------------------------------------------
  --  Indentation guides
  use {'lukas-reineke/indent-blankline.nvim'}

  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      require('nvim-treesitter.install').update({
        with_sync = true
      })
    end
  }

  -- Collection of configurations for built-in LSP client
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  }

  -- Autocomplete
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'L3MON4D3/LuaSnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'saadparwaiz1/cmp_luasnip'
    }
  }

  -- Linter, for all languages
  use 'dense-analysis/ale'

  -- Jinja2 templates support
  -- use 'mitsuhiko/vim-jinja'

  -- Python file header
  -- use 'fisadev/vim-isort'

  -- Code autoformat
  -- use 'Chiel92/vim-autoformat'

  -- Markdown Preview
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })


end)
