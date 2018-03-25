set nocompatible              " be iMproved, required
filetype off                  " required

" ----- START VUNDLE ------
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" emmet code generation
Plugin 'mattn/emmet-vim'

" surround.vim
Plugin 'tpope/vim-surround'

" HTML tag matching
Plugin 'valloric/MatchTagAlways'

" commenting command
Plugin 'tpope/vim-commentary'

" git info in gutter
Plugin 'airblade/vim-gitgutter'

" themes
" Plugin 'chriskempson/base16-vim'
Plugin 'chr4/jellygrass.vim'

" CtrlP fuzzy search file open
" Plugin 'kien/ctrlp.vim'

" bracket/parens autocompletion
Plugin 'jiangmiao/auto-pairs'

" enhance javascript syntax
" Plugin 'jelera/vim-javascript-syntax'

" tabline for buffers
Plugin 'ap/vim-buftabline'

" JS indenting (plus a couple of extra visual features)
" Plugin 'pangloss/vim-javascript'
" Plugin 'nathanaelkane/vim-indent-guides'

" nerdtree
Plugin 'scrooloose/nerdtree'

" nerdtree git plugin
" Plugin 'Xuyuanp/nerdtree-git-plugin'

" EditorConfig
Plugin 'editorconfig/editorconfig-vim'

" PICO-8 syntax
" Plugin 'justinj/vim-pico8-syntax'

" autosave files
" Plugin 'vim-scripts/vim-auto-save'

" minimap plugin
" Plugin 'severin-lemaignan/vim-minimap'

call vundle#end()            " required
filetype plugin indent on    " required

" ------ END VUNDLE --------

" colors
set background=dark
set t_Co=256

syntax on
" set cursorline
set mouse=a
set autoindent
set number
set backspace=indent,eol,start " make backspace outside of current insert session
let mapleader = ","
let g:vim_json_syntax_conceal = 0

" fuzzy finder
set path+=** " recurse :find
set wildmenu " tab multiple matches
nnoremap <leader>p :find<space>

" yank to system clipboard
" set clipboard=unnamed

" vim-javascript configuration
let javascript_enable_domhtmlcss = 1

" check linter on file open
" let g:syntastic_check_on_open = 1
" let g:syntastic_javascript_checkers = ['eslint']
" let g:syntastic_html_checkers=['']

" enable buftabline indicators
let g:buftabline_indicators = 1

" ctrl p configuration
nmap <C-e> :CtrlPBuffer<CR>
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py|node_modules'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_dotfiles = 0
let g:ctrlp_switch_buffer = 0

" autosave configuration
" let g:auto_save = 1 " enable autosave on vim startup
" let g:auto_save_in_insert_mode = 0 " do not save while in insert mode

" git gutter configuration
set updatetime=250
let g:gitgutter_realtime = 1
let g:gitgutter_eater = 1

nnoremap <leader>n :NERDTreeToggle<cr>

" nerdtree git plugin config
" let g:NERDTreeIndicatorMapCustom = {
"     \ "Modified"  : "✹",
"     \ "Staged"    : "✚",
"     \ "Untracked" : "✭",
"     \ "Renamed"   : "➜",
"     \ "Unmerged"  : "═",
"     \ "Deleted"   : "✖",
"     \ "Dirty"     : "✗",
"     \ "Clean"     : "✔︎",
"     \ "Unknown"   : "?"
"     \ 
" }

" handle JSON syntax without plugin
autocmd BufNewFile,BufRead *.json set ft=javascript

" tabs
set tabstop=2
set shiftwidth=2
set smarttab
set expandtab

set ssop-=options    " do not store global and local values in a session
set ssop-=folds      " do not store folds

set hidden

nnoremap <leader>e :bnext<CR>
nnoremap <leader>w :bprev<CR>
"nnoremap <leader>q :bdelete<CR>
nnoremap <leader>q :bp<cr>:bd #<cr>

" fix colors
" if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
"   set t_Co=256
" endif

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

