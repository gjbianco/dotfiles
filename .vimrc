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
call minpac#add('Yggdroot/indentLine')
call minpac#add('jpalardy/vim-slime')
call minpac#add('yegappan/lsp')
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-repeat')
call minpac#add('tpope/vim-unimpaired')

" language-specific
call minpac#add('gjbianco/vim-asciidoc-syntax')
call minpac#add('mattn/emmet-vim')
call minpac#add('vim-scripts/todo-txt.vim')

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
let g:slime_target = "tmux"
let g:slime_bracketed_paste = 1
let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}

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
colorscheme gruvbox
set background=dark
set statusline=%f%=%{substitute(getcwd(),$HOME,'~','')}\ %y\ %l:%c

au BufNewFile,BufRead Jenkinsfile setf groovy
au BufNewFile,BufRead Containerfile setf dockerfile
au FileType asciidoc setlocal commentstring=//\ %s

" mode toggles in the style of vim-unimpaired
nnoremap yog :exe "set signcolumn=" .. (&signcolumn == "yes" ? "no" : "yes")<CR>
nnoremap yoo :IndentLinesToggle<CR>

" LSP commands
nnoremap K :LspHover<CR>
nnoremap <leader>d :LspPeekDefinition<CR>
nnoremap <C-]> :LspGotoDefinition<CR>

" work-specific shortcuts
xnoremap <leader>wl :keepp s/\\\n//g<CR>
nnoremap <leader>wr :r! ssh workstation -q 
nnoremap <leader>wb :!sk flamel && rm -rf guides/tmp && flamel sg<CR>
nnoremap <leader>wg :!rsync -r classroom workstation:grading --delete<CR>
nnoremap <leader>wsw :!scp guides/tmp/en-US/pdf/*.pdf workpad:Downloads<CR>
nnoremap <leader>wp :!zathura guides/tmp/en-US/pdf/*.pdf &<CR>
nnoremap <leader>ww :!scp "%" workstation:<CR>
xnoremap <silent> i* :<C-u>keepp normal! T*vt*<CR>
onoremap <silent> i* :<C-u>keepp normal! T*vt*<CR>

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

let lspOpts = #{
\  autoComplete: v:false,
\  completionMatcher: 'fuzzy',
\  diagVirtualTextAlign: 'after',
\  hoverInPreview: v:false,
\  ignoreMissingServer: v:true,
\  noNewlineInCompletion: v:true,
\  semanticHighlight: v:true,
\  showDiagInPopup: v:false,
\  showDiagOnStatusLine: v:true,
\  usePopupInCodeAction: v:true,
\  filterCompletionDuplicates: v:true,
\}
autocmd User LspSetup call LspOptionsSet(lspOpts)

let lspServers = [
\  #{
\    name: 'tsserver',
\    filetype: ['javascript', 'typescript', 'typescriptreact'],
\    path: 'typescript-language-server',
\    args: ['--stdio'],
\  },
\  #{
\    name: 'pyright',
\    filetype: ['python'],
\    path: 'pyright-langserver',
\    args: ['--stdio'],
\    workspaceConfig: #{
\      python: #{
\        pythonPath: 'python'
\      }
\    }
\  },
\]
autocmd User LspSetup call LspAddServer(lspServers)
