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

" Set moving to next (n) previous (N) character when searching with f or t
noremap n ;
noremap N ,

" Commands for moving and deleting to end/beginning of line optimized for swe-keyboard
noremap - $
noremap , ^

" Map x to a delete without yanking
nmap x "_d
vmap x "_d
nmap xx "_dd

" To make copy-pasting (and toggling the paste-mode) easier
nnoremap <F2> :set invpaste paste?<CR>

" Replace currently selected text with default register
" without yanking it. In other words, 'paste-in-place'
vnoremap p "_dP

" Unset space to allow the leader key to be set to space
nnoremap <SPACE> <Nop>
" Set leader key
let mapleader = " "
