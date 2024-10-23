if empty(glob('~/.vim/pack/minpac/opt/minpac/autoload/minpac/impl.vim'))
  silent !git clone https://github.com/k-takata/minpac.git ~/.vim/pack/minpac/opt/minpac
endif
packadd minpac
call minpac#init()

call minpac#add('k-takata/minpac', {'type': 'opt'})
call minpac#add('morhetz/gruvbox')
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-repeat')
call minpac#add('tpope/vim-unimpaired')
call minpac#add('tpope/vim-vinegar')
call minpac#add('kana/vim-smartinput')
call minpac#add('airblade/vim-gitgutter')
call minpac#add('yegappan/lsp')
call minpac#add('prettier/vim-prettier')
call minpac#add('gjbianco/vim-asciidoc-syntax')
call minpac#add('mattn/emmet-vim')
call minpac#add('govim/govim')

let g:gruvbox_guisp_fallback = "bg" " fix spell colors for gruvbox
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0
let g:markdown_fenced_languages = ['html', 'js=javascript', 'ruby', 'go', 'rust']

au BufNewFile,BufRead Jenkinsfile setf groovy
au BufNewFile,BufRead Containerfile setf dockerfile
au FileType asciidoc setlocal commentstring=//\ %s

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
set statusline=%m%f%=%y\ %l:%c
set noswapfile
let mapleader = ","

nnoremap <Space> za
nnoremap <leader>b :bd<CR>
nnoremap <leader>, ,
nnoremap <leader>e :e **/
tnoremap <Esc> <C-\><C-n>
tnoremap <C-v><Esc> <Esc>
nnoremap yog :exe "set signcolumn=" .. (&signcolumn == "yes" ? "no" : "yes")<CR>

" work-specific shortcuts
xnoremap <leader>wl :keepp s/\\\n//g<CR>
nnoremap <leader>wr :r! ssh workstation -q 
nnoremap <leader>wb :!sk flamel && rm -rf guides/tmp && flamel sg<CR>
nnoremap <leader>wg :!rsync -r classroom workstation:grading --delete<CR>
nnoremap <leader>ww :!scp "%" workstation:<CR>
xnoremap <silent> i* :<C-u>keepp normal! T*vt*<CR>
onoremap <silent> i* :<C-u>keepp normal! T*vt*<CR>

" LSP config
nnoremap K :LspHover<CR>
nnoremap <leader>d :LspPeekDefinition<CR>
nnoremap <C-]> :LspGotoDefinition<CR>
nnoremap <leader>a :LspCodeAction<CR>

au User LspSetup call LspOptionsSet(#{
\  autoComplete: v:false,
\  omniComplete: v:true,
\  completionMatcher: 'fuzzy',
\  diagVirtualTextAlign: 'after',
\  hideDisabledCodeActions: v:true,
\  ignoreMissingServer: v:true,
\  noNewlineInCompletion: v:true,
\  semanticHighlight: v:true,
\  showDiagInPopup: v:false,
\  showDiagOnStatusLine: v:true,
\  usePopupInCodeAction: v:true,
\  filterCompletionDuplicates: v:true,
\})

au User LspSetup call LspAddServer([
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
\  #{
\    name: 'openscad',
\    filetype: ['openscad'],
\    path: 'openscad-lsp'
\  }
\])
