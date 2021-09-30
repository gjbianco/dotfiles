" auto install minpac plugin manager
if empty(glob('~/.vim/pack/minpac/opt/minpac/autoload/minpac/impl.vim'))
  silent !git clone https://github.com/k-takata/minpac.git ~/.vim/pack/minpac/opt/minpac
endif
packadd minpac
call minpac#init()
call minpac#add('k-takata/minpac', {'type': 'opt'})

" navigation
call minpac#add('editorconfig/editorconfig-vim')
call minpac#add('ap/vim-buftabline')
call minpac#add('kien/ctrlp.vim')
call minpac#add('morhetz/gruvbox')
call minpac#add('junegunn/goyo.vim')
call minpac#add('preservim/nerdtree')

" git
call minpac#add('airblade/vim-gitgutter')
call minpac#add('itchyny/vim-gitbranch')
call minpac#add('tpope/vim-fugitive')

" all hail Pope Tim
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-repeat')
call minpac#add('tpope/vim-unimpaired')
" minpac#add('tpope/vim-projectionist')

" language plugins
call minpac#add('dense-analysis/ale')
" call minpac#add('Shougo/deoplete.nvim')
call minpac#add('habamax/vim-asciidoctor')
" call minpac#add('pangloss/vim-javascript')
" call minpac#add('leafgarland/typescript-vim')
" call minpac#add('HerringtonDarkholme/yats.vim')
call minpac#add('cespare/vim-toml')
call minpac#add('rust-lang/rust.vim')
call minpac#add('vim-python/python-syntax')

" custom filetype syntax mappings
au BufNewFile,BufRead Jenkinsfile setf groovy
au BufNewFile,BufRead Containerfile setf Dockerfile

let mapleader = "," " set leader to space
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)|node_modules$'
let g:buftabline_indicators = 1
let g:gruvbox_guisp_fallback = "bg" " fix spell colors for gruvbox
let g:rustfmt_autosave = 1
let g:python_highlight_all = 1
let g:goyo_height = '95%'
let g:ale_fix_on_save = 1
let js_fixers = ['prettier', 'eslint']
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript':      js_fixers,
\   'javascript.jsx':  js_fixers,
\   'typescript':      js_fixers,
\   'typescriptreact': js_fixers,
\   'css':  ['prettier'],
\   'json': ['prettier'],
\}

syntax on           " syntax highlighting
set mouse=a         " use mouse controls
set number          " line numbers
set linebreak       " AKA wordwrap
set autoindent      " \
set tabstop=2       "  \
set shiftwidth=2    "   } indentation
set smarttab        "  /
set expandtab       " /
set ssop-=options   " do not store global and local values in a session
set ssop-=folds     " do not store folds
set ignorecase      " case insensitive search
set smartcase       " smart sensitive search
set background=dark " \
colorscheme gruvbox "  } colors
set t_Co=256        " /
set backspace=indent,eol,start
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,node_modules/**,.git/**,yarn.lock,package-lock.json,build/**
set hidden          " \
set nobackup        "  \
set nowritebackup   "   } for CoC
set updatetime=300  "  /
set shortmess+=c    " /
hi Normal guibg=NONE ctermbg=NONE

" custom statusline
function! StatuslineGit()
  let l:branchname = gitbranch#name()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction
function! SubbedCWD()
  return substitute(getcwd(), $HOME, '~', '')
endfunction
set statusline=%#PmenuSel#%{StatuslineGit()}%#StatusLineNC#
set statusline+=%{expand('%:t')}%=\ %{SubbedCWD()}\ %y\ %l:%c

function! ToggleSignColumn()
	if(&signcolumn == "no")
		set signcolumn=yes
	else
		set signcolumn=no
	endif
endfunction

nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>g :Goyo<CR>
nnoremap <leader>s :call ToggleSignColumn()<CR>
nmap <silent> <leader>aj :ALENext<CR>
nmap <silent> <leader>ak :ALEPrevious<CR>
nnoremap K :ALEHover<CR>
nnoremap <silent> gr :ALEFindReferences<CR>
nnoremap <leader>rn :ALERename<CR>
nnoremap <leader>qf :ALECodeAction<CR>
vnoremap <leader>qf :ALECodeAction<CR>

" Ctrl+hjkl to navigate splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" navigate buffers
nnoremap <leader>e :bnext<CR>
nnoremap <leader>w :bprev<CR>
nnoremap <leader>q :bp<cr>:bd #<cr>

nnoremap <leader>a A;<Esc>

" custom autocommands
augroup HiglightTODO
  autocmd!
  autocmd WinEnter,VimEnter * :silent! call matchadd('Todo', 'TODO', -1)
  autocmd WinEnter,VimEnter * :silent! call matchadd('Fixme', 'FIXME', -1)
  autocmd WinEnter,VimEnter * :silent! call matchadd('Note', 'NOTE', -1)
augroup END
" augroup asciidoctor
"   au!
"   au BufEnter *.adoc,*.asciidoc call AsciidoctorMappings()
" augroup END

" terminal mode bindings
if has('nvim')
  tnoremap <C-v><Esc> <Esc>
endif

" vimdiff config
if &diff
  highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
  highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
  highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
  highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red
  " git mergetool commands
  map <leader>1 :diffget LOCAL<CR>
  map <leader>2 :diffget BASE<CR>
  map <leader>3 :diffget REMOTE<CR>
endif
