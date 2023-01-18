if empty(glob('~/.vim/pack/minpac/opt/minpac/autoload/minpac/impl.vim'))
  silent !git clone https://github.com/k-takata/minpac.git ~/.vim/pack/minpac/opt/minpac
endif
packadd minpac
call minpac#init()

call minpac#add('k-takata/minpac', {'type': 'opt'})
call minpac#add('morhetz/gruvbox')
call minpac#add('editorconfig/editorconfig-vim')
call minpac#add('ap/vim-buftabline')
call minpac#add('preservim/nerdtree')
call minpac#add('mihaicristiantanase/vim-toggle-qf')
call minpac#add('kana/vim-fakeclip')
call minpac#add('kana/vim-smartinput')
call minpac#add('airblade/vim-gitgutter')
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-repeat')
call minpac#add('tpope/vim-unimpaired')
call minpac#add('tpope/vim-projectionist')

" snippets
call minpac#add('MarcWeber/vim-addon-mw-utils')
call minpac#add('tomtom/tlib_vim')
call minpac#add('garbas/vim-snipmate')
call minpac#add('honza/vim-snippets')
call minpac#add('gjbianco/vim-gls-snippets')

" language-specific plugins
call minpac#add('habamax/vim-asciidoctor')
call minpac#add('leafgarland/typescript-vim')
call minpac#add('HerringtonDarkholme/yats.vim')
call minpac#add('psf/black')

au BufNewFile,BufRead Jenkinsfile setf groovy
au BufNewFile,BufRead Containerfile setf dockerfile
au BufNewFile,BufRead *.fish setf sh

let g:buftabline_indicators = 1
let g:snipMate = {'snippet_version': 1}
let g:gruvbox_guisp_fallback = "bg" " fix spell colors for gruvbox

filetype plugin indent on
syntax on           " syntax highlighting
set mouse=a         " use mouse controls
set scl=no          " hide signs by default
set autoindent      " \
set tabstop=2       "  \
set shiftwidth=2    "   } indentation
set smarttab        "  /
set expandtab       " /
set ssop-=options   " do not store global and local values in a session
set ignorecase      " case insensitive search/completion
set smartcase       " smart sensitive search
set backspace=indent,eol,start
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,node_modules/**,.git/**,yarn.lock,package-lock.json,build/**
set laststatus=2    " show statusline
set hidden
set updatetime=300  " update git column faster
set omnifunc=syntaxcomplete#Complete
set background=dark
set t_Co=256
colorscheme gruvbox
hi Normal guibg=NONE ctermbg=NONE

set statusline=%f%=%{substitute(getcwd(),$HOME,'~','')}\ %y\ %l:%c

nnoremap yog :exe "set signcolumn=" .. (&signcolumn == "yes" ? "no" : "yes")<CR>
nnoremap yoq :call QFToggleFun()<CR>
nnoremap <leader>wr :r! ssh workstation -q 
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>fn :NERDTreeFind<CR>
nnoremap <leader>b :bp<cr>:bd #<cr>
nnoremap <leader>l :Electure 
nnoremap <leader>e :Ege
imap <C-l> <Plug>snipMateShow
tnoremap <Esc> <C-\><C-n>

if &diff
  highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
  highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
  highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
  highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red
  map <leader>1 :diffget LOCAL<CR>
  map <leader>2 :diffget BASE<CR>
  map <leader>3 :diffget REMOTE<CR>
endif

let g:projectionist_heuristics = {
\ "guides/en-US/sg-chapters/topics/": {
\   "content/*/lecture.adoc": {
\     "type": "lecture"
\   },
\   "content/*/ge.adoc": {
\      "type": "ge",
\      "alternate": "content/*/lecture.adoc"
\    },
\    "content/*/matching.adoc": {
\      "type": "quiz",
\      "alternate": "content/*/lecture.adoc"
\    },
\    "content/*/review/lab.adoc": {
\      "type": "lab"
\    },
\
\    "classroom/grading/src/*.py": {
\      "type": "dyno"
\    }
\   }
\ }
