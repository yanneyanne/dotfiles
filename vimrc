" To enable saving with Ctrl-s
nmap <C-s> :w<CR>
imap <C-s> <Esc>:w<CR>a

" Shortcuts for moving between tabs
" Ctrl-h to moveleft
nmap <C-h> gT
imap <C-h> <Esc>gT

" Ctrl-l to move right
nmap <C-l> gt
imap <C-l> <Esc>gt

" Commands for moving to end/beginning of line optimized for swe-keyboard
nmap - $
nmap , ^
nmap d- d$
nmap d, d^

"Map folds to automatically be set to indentation
set foldmethod=indent

"Shows all folds which are indented less then the specified number
set foldlevelstart=10

" Set maximum number of nested folds
set foldnestmax=5

" To remap closing and opening folds to space
nnoremap <space> za

" To make copy-pasting (and toggling the paste-mode) easier
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" Show line numbers
set number

" To activate smartcase-searching
set smartcase

" Vim starts searching during search keyword typing
set incsearch

" Next line starts with same indentation
set autoindent

" Set the tab width
set tabstop=4

" Highlight the current line
set cursorline
" Set cursorline colors
highlight CursorLine ctermbg=235
" Set color of number column on cursorline
highlight CursorLineNR ctermbg=235 ctermfg=white

" Error bells are displayed visually
set visualbell

" Show active mode
set showmode

" Plugins
call plug#begin('$HOME/.config/nvim/plugged')
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'mhartington/oceanic-next'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-sleuth'
Plug 'w0rp/ale'
Plug 'artur-shaik/vim-javacomplete2'
call plug#end()

" Vim-airline
set laststatus=2
let g:lightline = {
    \ 'colorscheme': 'oceanicnext',
\}

" For Neovim 0.1.3 and 0.1.4
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Or if you have Neovim >= 0.1.5
if (has("termguicolors"))
 set termguicolors
endif

set background=dark
syntax enable
colorscheme OceanicNext

" omnifuncs (deoplete)
augroup omnifuncs
    autocmd!
    autocmd FileType java setlocal omnifunc=javacomplete#Complete
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end

let g:deoplete#enable_at_startup = 1
if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
endif
" let g:deoplete#disable_auto_complete = 1
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
