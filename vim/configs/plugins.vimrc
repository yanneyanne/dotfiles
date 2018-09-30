" Set color settings to accomodate Oceanic-Next
if (has("termguicolors"))
 set termguicolors
endif
set background=dark
syntax enable
colorscheme OceanicNext

" Have statusline always be visible
set laststatus=2

" Disable awkard sidebar default error indicators
let g:ale_set_signs=0

" All ALE indicators should be highlight-based
let g:ale_set_highlights=1

" Highlight error lines with an underline and change the color to red
highlight ALEErrorLine guifg=#ec5f67

" Highlight warning token with an underline and change the color to yellow
highlight ALEWarningLine guifg=#fac863

" Navigate to the previous ALE erorr with Ctrl-p
map <silent> <C-p> <Plug>(ale_previous_wrap)
"
" Navigate to the next ALE erorr with Ctrl-n
map <silent> <C-n> <Plug>(ale_next_wrap)

" Make Lightline use Oceanic-Next
let g:lightline = {
    \ 'colorscheme': 'oceanicnext',
\}

" Register ALE-linting related components
let g:lightline.component_expand = {
    \  'linter_checking': 'lightline#ale#checking',
    \  'linter_warnings': 'lightline#ale#warnings',
    \  'linter_errors': 'lightline#ale#errors',
    \  'linter_ok': 'lightline#ale#ok',
    \ }

" Colorize ALE for Lightline components
let g:lightline.component_type = {
    \     'linter_checking': 'left',
    \     'linter_warnings': 'warning',
    \     'linter_errors': 'error',
    \     'linter_ok': 'left',
    \ }

" Add components to Lightline
let g:lightline.active = {
    \ 'left': [['readonly', 'filename', 'modified']],
    \ 'right': [[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok', 'lineinfo', 'percent']]
    \ }

" Set lightline ALE components to use icons
" The spaces ensure that icons line up
let g:lightline#ale#indicator_checking = " \u25F7 "
let g:lightline#ale#indicator_warnings = "\u26A0 "
let g:lightline#ale#indicator_errors = "\u2715 "
let g:lightline#ale#indicator_ok = " \u2714 "

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

" deoplete - use tab to cycle between autocompletion alternatives
" and shift-tab to cycle in reversed order
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"
