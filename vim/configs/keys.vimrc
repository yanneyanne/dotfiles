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

" To remap closing and opening folds to space
nnoremap <space> za

" To make copy-pasting (and toggling the paste-mode) easier
nnoremap <F2> :set invpaste paste?<CR>
