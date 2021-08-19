" auto install minpac plugin manager
if empty(glob('~/.vim/pack/minpac/opt/minpac/autoload/minpac/impl.vim'))
  silent !git clone https://github.com/k-takata/minpac.git ~/.vim/pack/minpac/opt/minpac
endif
packadd minpac
call minpac#init()

call minpac#add('k-takata/minpac', {'type': 'opt'})
call minpac#add('neoclide/coc.nvim', {'branch': 'release'})
call minpac#add('editorconfig/editorconfig-vim')
call minpac#add('ap/vim-buftabline')
call minpac#add('kien/ctrlp.vim')
call minpac#add('morhetz/gruvbox')
call minpac#add('junegunn/goyo.vim')
call minpac#add('ptzz/lf.vim', {'rev': 'v1.3~1'})
call minpac#add('rbgrouleff/bclose.vim') " required for LF

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

" language-specific plugins
call minpac#add('habamax/vim-asciidoctor')
call minpac#add('pangloss/vim-javascript')
call minpac#add('leafgarland/typescript-vim')
call minpac#add('HerringtonDarkholme/yats.vim')
call minpac#add('cespare/vim-toml')
call minpac#add('rust-lang/rust.vim')
call minpac#add('vim-python/python-syntax')

" custom filetype syntax mappings
au BufNewFile,BufRead Jenkinsfile setf groovy
au BufNewFile,BufRead Containerfile setf Dockerfile
" au BufNewFile,BufRead *.toml setf config

let mapleader = "," " set leader to space
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)|node_modules$'
let g:buftabline_indicators = 1
let g:gruvbox_guisp_fallback = "bg" " fix spell colors for gruvbox
let g:lf_map_keys = 0
let g:lf_replace_netrw = 1 " open lf when vim opens a directory
let g:rustfmt_autosave = 1
let g:python_highlight_all = 1
let g:goyo_height = '95%'
let g:coc_global_extensions = [
  \ 'coc-pairs',
  \ 'coc-prettier', 
  \ 'coc-json', 
  \ 'coc-emmet',
  \ 'coc-tsserver',
  \ 'coc-rls',
  \ 'coc-pyright'
  \ ]

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

nnoremap <leader>n :Lf<CR>
nnoremap <leader>pn :LfWorkingDirectory<CR>
nnoremap <leader>g :Goyo<CR>
nnoremap <leader>s :call ToggleSignColumn()<CR>

" Ctrl+hjkl to navigate splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" navigate buffers
nnoremap <leader>e :bnext<CR>
nnoremap <leader>w :bprev<CR>
nnoremap <leader>q :bp<cr>:bd #<cr>

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

" CoC readme settings
if has("patch-8.1.1564")
  set signcolumn=number
else
  set signcolumn=yes
endif
set scl=no

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif
inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')
augroup mygroup
  autocmd!
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

command! -nargs=0 Format :call CocAction('format') " Add `:Format` command to format current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>) " Add `:Fold` command to fold current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport') " Add `:OR` command for organize imports of the current buffer.

" CoC mappings
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nnoremap <silent> K :call <SID>show_documentation()<CR>
