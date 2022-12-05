if empty(glob('~/.vim/pack/minpac/opt/minpac/autoload/minpac/impl.vim'))
  silent !git clone https://github.com/k-takata/minpac.git ~/.vim/pack/minpac/opt/minpac
endif
packadd minpac

call minpac#init()
call minpac#add('k-takata/minpac', {'type': 'opt'})
call minpac#add('morhetz/gruvbox')
call minpac#add('editorconfig/editorconfig-vim')
call minpac#add('ap/vim-buftabline')
call minpac#add('kien/ctrlp.vim')
call minpac#add('preservim/nerdtree')
call minpac#add('mihaicristiantanase/vim-toggle-qf')
call minpac#add('kana/vim-fakeclip')
call minpac#add('kana/vim-smartinput')
call minpac#add('airblade/vim-gitgutter')

" all hail Pope Tim
call minpac#add('tpope/vim-fugitive')
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-repeat')
call minpac#add('tpope/vim-unimpaired')
call minpac#add('tpope/vim-projectionist')

" language-specific plugins
call minpac#add('habamax/vim-asciidoctor')
call minpac#add('leafgarland/typescript-vim')
call minpac#add('HerringtonDarkholme/yats.vim')
call minpac#add('fatih/vim-go')

au BufNewFile,BufRead Jenkinsfile setf groovy
au BufNewFile,BufRead Containerfile setf dockerfile
au BufNewFile,BufRead *.fish setf sh

let mapleader = ","
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)|node_modules$'
let g:buftabline_indicators = 1
let g:gruvbox_guisp_fallback = "bg" " fix spell colors for gruvbox

let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
let g:go_fmt_command = "goimports"
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

filetype plugin indent on
syntax on           " syntax highlighting
set mouse=a         " use mouse controls
" set number          " line numbers
set scl=no          " hide signs by default
" set linebreak       " AKA wordwrap
set autoindent      " \
set tabstop=2       "  \
set shiftwidth=2    "   } indentation
set smarttab        "  /
set expandtab       " /
" set ssop-=options   " do not store global and local values in a session
" set ssop-=folds     " do not store folds
set ignorecase      " case insensitive search/completion
set smartcase       " smart sensitive search
set background=dark " \
colorscheme gruvbox "  } colors
set t_Co=256        " /
set backspace=indent,eol,start
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,node_modules/**,.git/**,yarn.lock,package-lock.json,build/**
set laststatus=2    " show statusline
set hidden          " \
" set nobackup        "  \
" set nowritebackup   "   } for CoC
" set updatetime=300  "  /
" set shortmess+=c    " /
set omnifunc=syntaxcomplete#Complete
hi Normal guibg=NONE ctermbg=NONE

function! SubbedCWD()
  return substitute(getcwd(), $HOME, '~', '')
endfunction
set statusline+=%{expand('%:t')}%=\ %{SubbedCWD()}\ %y\ %l:%c

function! ToggleSignColumn()
	if(&signcolumn == "no")
		set signcolumn=yes
	else
		set signcolumn=no
	endif
endfunction

nnoremap yog :call ToggleSignColumn()<CR>
nnoremap yoq :call QFToggleFun()<CR>
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>fn :NERDTreeFind<CR>
nnoremap <leader>b :bp<cr>:bd #<cr>
nnoremap <leader>a :A<CR>
nnoremap <leader>l :Electure 
nnoremap <leader>e :Ege 
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

autocmd FileType go nmap <leader>r :GoRun!<CR>
autocmd FileType go nmap <leader>t :GoTest!<CR>

" custom autocommands
augroup HiglightTODO
  autocmd!
  autocmd WinEnter,VimEnter * :silent! call matchadd('Todo', 'TODO', -1)
  autocmd WinEnter,VimEnter * :silent! call matchadd('Fixme', 'FIXME', -1)
  autocmd WinEnter,VimEnter * :silent! call matchadd('Note', 'NOTE', -1)
augroup END

" improve highlighting stability in large files
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

" terminal mode ESC
if has('nvim')
  tnoremap <Esc> <C-\><C-n>
endif

if &diff
  highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
  highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
  highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
  highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red
  map <leader>1 :diffget LOCAL<CR>
  map <leader>2 :diffget BASE<CR>
  map <leader>3 :diffget REMOTE<CR>
endif

" projectionist global for GLS courses
let g:projectionist_heuristics = {
\ "guides/en-US/sg-chapters/topics/": {
\   "guides/en-US/sg-chapters/topics/*-ge-content.adoc": {
\      "type": "oge",
\      "alternate": "guides/en-US/sg-chapters/topics/{}-lecture-content.adoc"
\    },
\    "guides/en-US/sg-chapters/topics/*-mc-content.adoc": {
\      "type": "oquiz",
\      "alternate": "guides/en-US/sg-chapters/topics/{}-lecture-content.adoc"
\    },
\    "guides/en-US/sg-chapters/topics/*-lecture-content.adoc": {
\      "type": "olecture",
\    },
\    "guides/en-US/sg-chapters/topics/*-lab-content.adoc": {
\      "type": "olab"
\    },
\
\   "content/*/practice.adoc": {
\      "type": "ge",
\      "alternate": "content/*/lecture.adoc"
\    },
\    "content/*/matching.adoc": {
\      "type": "quiz",
\      "alternate": "content/*/lecture.adoc"
\    },
\    "content/*/lecture.adoc": {
\      "type": "lecture",
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
