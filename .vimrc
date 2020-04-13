set nocompatible

" auto install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

" languages
" Plug 'digitaltoad/vim-pug'
" Plug 'rust-lang/rust.vim'

" visual
Plug 'danilo-augusto/vim-afterglow'
Plug 'nathanaelkane/vim-indent-guides'

" navigation
Plug 'ap/vim-buftabline'
Plug 'scrooloose/nerdtree'
Plug 'kien/ctrlp.vim'

" general editing
Plug 'jiangmiao/auto-pairs'
Plug 'editorconfig/editorconfig-vim'
Plug 'godlygeek/tabular'

Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'branch': 'release/1.x',
  \ 'for': [
    \ 'javascript',
    \ 'typescript',
    \ 'css',
    \ 'less',
    \ 'scss',
    \ 'json',
    \ 'graphql',
    \ 'markdown',
    \ 'vue',
    \ 'lua',
    \ 'php',
    \ 'python',
    \ 'ruby',
    \ 'html',
    \ 'swift' ] }

" all hail Pope Tim
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'

call plug#end()

" colors
set background=dark
set t_Co=256
" colorscheme afterglow
colorscheme default

syntax on
set mouse=a
set hidden

set number
" set relativenumber
set backspace=indent,eol,start " make backspace outside of current insert session


" MacOSX/Linux
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,node_modules,yarn.lock,package-lock.json

set linebreak
set autoindent
set tabstop=2
set shiftwidth=2
set smarttab
set expandtab

let mapleader = "," " set leader to space

" toggle hlsearch
nnoremap <leader>h :set invhlsearch<CR>

" replace
nnoremap <leader>r :%s///g<Left><Left>

" CtrlP
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

" nerdtree
nnoremap <leader>n :NERDTreeToggle<CR>
let g:NERDTreeMinimalUI = 1
let g:NERDTreeAutoDeleteBuffer = 1

" enable buftabline indicators
let g:buftabline_indicators = 1

" goyo
let g:goyo_height = '95%'
nnoremap <leader>g :Goyo<CR>
autocmd! User GoyoEnter call EnterGoyo()
autocmd! User GoyoLeave call ExitGoyo()

" limelight
nnoremap <leader>l :Limelight!!<CR>
let g:limelight_conceal_ctermfg = 'darkgrey'

" configure how goyo enters and exits
function EnterGoyo()
  Limelight
  set showtabline=0
endfunction
function ExitGoyo()
  Limelight!
  set showtabline=2
endfunction

" handle colors different in vimdiff
if &diff
  " colorscheme evening
  highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
  highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
  highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
  highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red
endif

" handle JSON syntax without plugin
autocmd BufNewFile,BufRead *.json set ft=javascript

set ssop-=options    " do not store global and local values in a session
set ssop-=folds      " do not store folds

nnoremap <leader>e :bnext<CR>
nnoremap <leader>w :bprev<CR>
"nnoremap <leader>q :bdelete<CR>
nnoremap <leader>q :bp<cr>:bd #<cr>
