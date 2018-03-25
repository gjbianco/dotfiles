set nocompatible
" filetype off

" auto install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

" Plug 'mattn/emmet-vim'
Plug 'airblade/vim-gitgutter'
Plug 'jiangmiao/auto-pairs'
Plug 'ap/vim-buftabline'
Plug 'editorconfig/editorconfig-vim'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-vinegar'

call plug#end()

" colors
set background=dark
set t_Co=256

syntax on
set mouse=a
set hidden
set number
set relativenumber
set backspace=indent,eol,start " make backspace outside of current insert session
let mapleader = ","

set autoindent
set tabstop=2
set shiftwidth=2
set smarttab
set expandtab

" fuzzy finder
set path+=** " recurse :find
set wildmenu " tab multiple matches
nnoremap <leader>p :find<space>

" netrw
nnoremap <leader>n :e.<CR>
nnoremap <leader>b :Explore<CR>
cnoremap E Explore

" enable buftabline indicators
let g:buftabline_indicators = 1

" git gutter configuration
set updatetime=250
let g:gitgutter_realtime = 1
let g:gitgutter_eater = 1

" handle JSON syntax without plugin
autocmd BufNewFile,BufRead *.json set ft=javascript

set ssop-=options    " do not store global and local values in a session
set ssop-=folds      " do not store folds

nnoremap <leader>e :bnext<CR>
nnoremap <leader>w :bprev<CR>
"nnoremap <leader>q :bdelete<CR>
nnoremap <leader>q :bp<cr>:bd #<cr>

function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! PrettyXML call DoPrettyXML()

