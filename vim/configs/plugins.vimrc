" Load plugins
call plug#begin('$HOME/.config/nvim/plugged')
Plug 'neovim/nvim-lspconfig'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'williamboman/nvim-lsp-installer'

Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'rafamadriz/friendly-snippets'

Plug 'neanias/everforest-nvim', { 'branch': 'main' }
Plug 'tpope/vim-sleuth'
Plug 'Raimondi/delimitMate'
Plug 'mfussenegger/nvim-lint'
Plug 'nvim-lualine/lualine.nvim'
Plug 'sheerun/vim-polyglot/'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
call plug#end()


let g:python3_host_prog = expand('~/nvim-env/bin/python3')

" LSP configuration
set completeopt=menu,menuone,noselect

" The line below is not official
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require('cmp')

  -- Utils
  local check_backspace = function()
    local col = vim.fn.col "." - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
  end
  ----------------

  require("nvim-lsp-installer").setup {}

  -- Load snippets
  require("luasnip.loaders.from_vscode").lazy_load()

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ["<Tab>"] = cmp.mapping(function(fallback)
        local luasnip = require "luasnip"
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expandable() then
          luasnip.expand()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif check_backspace() then
          fallback()
        else
          fallback()
        end
	  end, {"i", "s"}),
	  ["<S-Tab>"] = cmp.mapping(function(fallback)
        local luasnip = require "luasnip"
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.expandable() then
          luasnip.expand()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif check_backspace() then
          fallback()
        else
          fallback()
        end
	  end, {"i", "s"}),
    }),
    snippet = {
      expand = function(args)
        local luasnip = prequire("luasnip")
        if not luasnip then
          return
        end
        luasnip.lsp_expand(args.body)
      end,
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' }, -- For luasnip users.
    }, {
      { name = 'buffer' },
    }),
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  -- cmp.setup.cmdline(':', {
  --   mapping = cmp.mapping.preset.cmdline(),
  --   sources = cmp.config.sources({
  --     { name = 'path' }
  --   }, {
  --     { name = 'cmdline' }
  --   })
  -- })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  local servers = {'bashls', 'eslint', 'tsserver', 'cssmodules_ls', 'tailwindcss'}
  for _, server in pairs(servers) do
    require('lspconfig')[server].setup {
      capabilities = capabilities,
      root_dir = require('lspconfig.util').root_pattern('.git')(fname)
    }
    -- require('lspconfig')[server].setup{
    --  root_dir = util.root_pattern('.git')(fname)
    -- }
  end
  -- Use å/Å to jump to the next or previous diagnostic errors
  vim.keymap.set('n', 'Å', vim.diagnostic.goto_prev)
  vim.keymap.set('n', 'å', vim.diagnostic.goto_next)
EOF

" Set color settings to accomodate Oceanic-Next
if (has("termguicolors"))
 set termguicolors
endif

set background=light

lua <<EOF
require('everforest').setup({
  ---Controls the "hardness" of the background. Options are "soft", "medium" or "hard".
  background = "medium"
})
EOF

" For better performance
let g:everforest_better_performance = 1
syntax enable
colorscheme everforest

" Have statusline always be visible
set laststatus=2


"""""""""""""""""""""""""""""""""""""""
" Linting
"""""""""""""""""""""""""""""""""""""""

lua <<EOF
require('lint').linters_by_ft = {
  markdown = {'vale',},
  python = {'flake8',},
  javascript = { "eslint", "tsserver"},
  typescriptreact = { "eslint", "tsserver" },
  typescript = { "eslint", "tsserver" },
}
EOF


lua <<EOF
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'everforest'
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {
      {
        'diagnostics',
        symbols = {error = '✕', warn = '⚠ ', info = 'I', hint = 'H'},
        colored = true,           -- Displays diagnostics status in color if set to true.
        update_in_insert = false, -- Update diagnostics in insert mode.
        always_visible = false   -- Show diagnostics even if there are none.
      }
    },
    lualine_c = {
      {
        'filename',
        symbols = {modified = '•'}
      }
    },
    lualine_x = {'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  winbar = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      {
        'filename',
        path = 1,
        symbols = {modified = '•'}
      }
    },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  }
}
EOF

" Set maximum line length to 120 for black python fixer
let g:black_linelength=120

""""""""""""""""""""""""""""""""""""
" Ag + Fzf
""""""""""""""""""""""""""""""""""""
" Use Ag as search backend if available
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" Make sure fuzzyfinding ignores the files in the gitignore
" but doesn't ignore the gitignore itself.
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore ".git" -g ""'

" Freeform text search
nnoremap <Leader>c :Ag<CR>

" Search file names
nnoremap <Leader>f :Files<CR>

" Search among open buffers
nnoremap <Leader>r :Buffers<CR>

" Place the fuzzyfinder window at the bottom of the vim screen
let g:fzf_layout = { 'down':  '40%'}

" Customize fzf colors to match color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
