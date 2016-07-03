

"colorscheme solarized

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
nmap ä $
nmap ö ^

"Map folds to automatically be set to indentation
set foldmethod=indent

"To remap closing and opening folds to space
:nnoremap <space> za

"Show line numbers
set number

"To activate smartcase-searching
set smartcase

"Vim starts searching during search keyword typing
set incsearch

"Next line starts with same indentation
set autoindent

"Error bells are displayed visually
set visualbell

"Show active mode
set showmode
