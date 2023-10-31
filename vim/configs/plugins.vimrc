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

Plug 'mhartington/oceanic-next'
Plug 'tpope/vim-sleuth'
Plug 'Raimondi/delimitMate'
Plug 'mfussenegger/nvim-lint'
Plug 'itchyny/lightline.vim'
Plug 'spywhere/lightline-lsp'
Plug 'maximbaz/lightline-ale'
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
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
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
EOF

" Set color settings to accomodate Oceanic-Next
if (has("termguicolors"))
 set termguicolors
endif

set background=dark
syntax enable
colorscheme OceanicNext

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

" Highlight error lines with an underline and change the color to red
highlight ALEErrorLine guifg=#ec5f67

" Highlight warning token with an underline and change the color to yellow
highlight ALEWarningLine guifg=#fac863
"
" Make Lightline use Oceanic-Next
let g:lightline = {
    \ 'colorscheme': 'oceanicnext',
\}

" Register linting related components
let g:lightline.component_expand = {
      \  'linter_hints': 'lightline#lsp#hints',
      \  'linter_infos': 'lightline#lsp#infos',
      \  'linter_warnings': 'lightline#lsp#warnings',
      \  'linter_errors': 'lightline#lsp#errors',
      \  'linter_ok': 'lightline#lsp#ok',
      \ }

" Colorize linter for Lightline components
let g:lightline.component_type = {
      \     'linter_hints': 'left',
      \     'linter_infos': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'left',
      \ }

" Add components to Lightline
let g:lightline.active = {
    \ 'left': [['readonly', 'filename', 'modified']],
    \ 'right': [[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok', 'lineinfo', 'percent']]
    \ }

" Set lightline linting components to use icons
" The spaces ensure that icons line up
let g:lightline#lsp#indicator_checking = " \u25F7 "
let g:lightline#lsp#indicator_warnings = "\u26A0 "
let g:lightline#lsp#indicator_errors = "\u2715 "
let g:lightline#lsp#indicator_ok = " \u2714 "


" Set maximum line length to 120 for black python fixer
let g:black_linelength=120

""""""""""""""""""""""""""""""""""""
" Ag + Fzf
""""""""""""""""""""""""""""""""""""
" Use Ag as search backend if available
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

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
