if empty(glob('~/.vim/pack/minpac/opt/minpac/autoload/minpac/impl.vim'))
  silent !git clone https://github.com/k-takata/minpac.git ~/.vim/pack/minpac/opt/minpac
endif
packadd minpac
call minpac#init()

call minpac#add('k-takata/minpac', {'type': 'opt'})
call minpac#add('morhetz/gruvbox')
call minpac#add('ap/vim-buftabline')
call minpac#add('preservim/nerdtree')
call minpac#add('kana/vim-smartinput')
call minpac#add('airblade/vim-gitgutter')
call minpac#add('dense-analysis/ale')
call minpac#add('Yggdroot/indentLine')
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-repeat')
call minpac#add('tpope/vim-unimpaired')
" call minpac#add('tpope/vim-projectionist')

" language-specific
call minpac#add('gjbianco/vim-asciidoc-syntax')
call minpac#add('mattn/emmet-vim')
call minpac#add('vim-scripts/todo-txt.vim')
" call minpac#add('fatih/vim-go')

" snippets
call minpac#add('MarcWeber/vim-addon-mw-utils')
call minpac#add('tomtom/tlib_vim')
call minpac#add('garbas/vim-snipmate')
call minpac#add('honza/vim-snippets')
call minpac#add('gjbianco/vim-gls-snippets')

let g:buftabline_indicators = 1
let g:snipMate = {'snippet_version': 1}
let g:gruvbox_guisp_fallback = "bg" " fix spell colors for gruvbox
let g:indentLine_char = '│'
let g:indentLine_enabled = 0
let g:ale_fix_on_save = 1
let g:ale_fixers = {
  \ 'go': ['gofmt','goimports'],
  \ 'gohtmltmpl': ['prettier'],
  \ 'html': ['prettier'],
  \ 'javascript': ['prettier'],
  \ 'python': ['black'],
  \ 'typescriptreact': ['prettier'],
  \ 'yaml': ['prettier']
\}
let g:ale_virtualtext_cursor = 'disabled'

" let g:go_doc_popup_window = 1
" let g:go_list_autoclose = 1
" let g:go_fmt_fail_silently = 1
" let g:go_highlight_operators = 1
" let g:go_highlight_function = 1
" let g:go_highlight_function_parameters = 1
" let g:go_highlight_function_calls = 1
" let g:go_highlight_types = 1
" let g:go_highlight_fields = 1
" let g:go_highlight_format_strings = 1
" let g:go_highlight_variable_declarations = 1
" let g:go_highlight_variable_assignments = 1

filetype plugin indent on
syntax on           " syntax highlighting
set mouse=a         " use mouse controls
set scl=no          " hide sign column
set autoindent      " \
set tabstop=2       "  \
set shiftwidth=2    "   } indentation
set smarttab        "  /
set expandtab       " /
set ssop-=options   " do not store global and local values in a session
set ignorecase      " case insensitive search/completion
set smartcase       " smart sensitive search
set laststatus=2    " show statusline
set updatetime=300  " update git column faster
set linebreak       " handle line wrapping better
set ttyfast
set hidden
set backspace=indent,eol,start
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,node_modules/**,.git/**,yarn.lock,package-lock.json,build/**
set omnifunc=ale#completion#OmniFunc
colorscheme gruvbox
set background=dark
set statusline=%f%=%{substitute(getcwd(),$HOME,'~','')}\ %y\ %l:%c

au BufNewFile,BufRead Jenkinsfile setf groovy
au BufNewFile,BufRead Containerfile setf dockerfile
au FileType asciidoc setlocal commentstring=//\ %s

" mode toggles in the style of vim-unimpaired
nnoremap yog :exe "set signcolumn=" .. (&signcolumn == "yes" ? "no" : "yes")<CR>
nnoremap yoo :IndentLinesToggle<CR>

" work-specific shortcuts
xnoremap <leader>wl :keepp s/\\\n//g<CR>
nnoremap <leader>wr :r! ssh workstation -q 
nnoremap <leader>wb :!sk flamel && rm -rf guides/tmp && flamel sg<CR>
nnoremap <leader>wsm :!scp guides/tmp/en-US/pdf/*.pdf guys-macbook-air:Desktop<CR>
nnoremap <leader>wp :!zathura guides/tmp/en-US/pdf/*.pdf &<CR>
nnoremap <leader>ww :!scp "%" workstation:<CR>
xnoremap <silent> i* :<C-u>keepp normal! T*vt*<CR>
onoremap <silent> i* :<C-u>keepp normal! T*vt*<CR>

" ALE mappings
nnoremap K :ALEHover<CR>
nnoremap <leader>aa :ALECodeAction<CR>
nnoremap <leader>ad :ALEGoToDefinition<CR>
nnoremap ]z :ALENext<cr>
nnoremap [z :ALEPrevious<cr>

nnoremap <Space> za
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>fn :NERDTreeFind<CR>
nnoremap <leader>b :bd<CR>
imap <C-l> <Plug>snipMateShow
tnoremap <Esc> <C-\><C-n>
tnoremap <C-v><Esc> <Esc>

if &diff
  highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
  highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
  highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
  highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red
  map <leader>1 :diffget LOCAL<CR>
  map <leader>2 :diffget BASE<CR>
  map <leader>3 :diffget REMOTE<CR>
endif

" let g:projectionist_heuristics = {
" \   "guides/en-US/sg-chapters/topics/": {
" \     "content/*/lecture.adoc": {
" \       "type": "lecture"
" \     },
" \     "content/*/ge.adoc": {
" \       "type": "ge",
" \     },
" \     "classroom/grading/src/*.py": {
" \       "type": "dyno"
" \     }
" \   }
" \ }
