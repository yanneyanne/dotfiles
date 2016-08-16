
execute pathogen#infect()

syntax enable
set term=screen-256color
set background=dark
colorscheme solarized

"To enable saving with Ctrl-s
nmap <C-s> :w<CR>
imap <C-s> <Esc>:w<CR>a

"Shortcuts for moving between tabs
"Ctrl-h to moveleft
nmap <C-h> gT
imap <C-h> <Esc>gT

"Ctrl-l to move right
nmap <C-l> gt
imap <C-l> <Esc>gt

"Commands for moving to end/beginning of line optimized for swe-keyboard
nmap - $
nmap , ^
nmap d- d$
nmap d, d^

"Map folds to automatically be set to indentation
set foldmethod=indent

"Shows all folds which are indented less then the specified number
set foldlevelstart=10

"Set maximum number of nested folds
set foldnestmax=5

"To remap closing and opening folds to space
nnoremap <space> za

"Show line numbers
set number

"To activate smartcase-searching
set smartcase

"Vim starts searching during search keyword typing
set incsearch

"Next line starts with same indentation
set autoindent

"Set tab-width
set tabstop=4

"Error bells are displayed visually
set visualbell

"Show active mode
set showmode

"The following lines are needed for CtrlSpace-compatibility
set nocompatible
set hidden
set showtabline=0

"Vim-airline
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'solarized',
	        \ }

"Recommended settings for syntastic
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
