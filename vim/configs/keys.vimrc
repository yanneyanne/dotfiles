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

" Commands for moving and deleting to end/beginning of line optimized for swe-keyboard
nmap - $
nmap , ^
nmap d- d$
nmap d, d^
" The same end/beginning of line changes as above, but in visual mode
vmap - $
vmap , ^
vmap d- d$
vmap d, d^

" To make copy-pasting (and toggling the paste-mode) easier
nnoremap <F2> :set invpaste paste?<CR>

" Delete with 'd' and 'dd' without yanking
" Note that copy registers can still manually be specified
nnoremap d "_d
nnoremap dd "_dd
vnoremap d "_d
vnoremap dd "_dd

" Replace currently selected text with default register
" without yanking it. In other words, 'paste-in-place'
vnoremap p "_dP

" Unset space to allow the leader key to be set to space
nnoremap <SPACE> <Nop>
" Set leader key
let mapleader = " "
