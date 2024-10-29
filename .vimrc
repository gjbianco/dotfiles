colorscheme gruvbox
set background=dark
set mouse=a        " use mouse controls
set scl=no         " hide sign column
set autoindent     " \
set tabstop=2      "  \
set shiftwidth=2   "   } indentation
set expandtab      "  /
set ignorecase     " case insensitive search/completion
set smartcase      " smart sensitive search
set updatetime=300 " update git column faster
set linebreak      " handle line wrapping better
set hidden         " hide modified buffer without abandoning
set noswapfile
set ttyfast
set statusline=%m%f%=%y\ %l:%c
set wildignore+=node_modules/**,.git/**
let mapleader=","

if empty(glob('~/.vim/pack/minpac/opt/minpac/autoload/minpac/impl.vim'))
  silent !git clone https://github.com/k-takata/minpac.git ~/.vim/pack/minpac/opt/minpac
endif
packadd minpac
call minpac#init()

call minpac#add('k-takata/minpac', {'type': 'opt'})
call minpac#add('morhetz/gruvbox')
call minpac#add('tpope/vim-repeat')
call minpac#add('tpope/vim-vinegar')
call minpac#add('tpope/vim-sensible')
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-unimpaired')
call minpac#add('yegappan/lsp')
call minpac#add('fatih/vim-go')
call minpac#add('mattn/emmet-vim')
call minpac#add('ap/vim-buftabline')
call minpac#add('kana/vim-smartinput')
call minpac#add('prettier/vim-prettier')
call minpac#add('airblade/vim-gitgutter')
call minpac#add('gjbianco/vim-asciidoc-syntax')

let g:buftabline_indicators=1
let g:prettier#autoformat=1
let g:prettier#autoformat_require_pragma=0
let g:gruvbox_guisp_fallback="bg"
let g:markdown_fenced_languages=['html', 'js=javascript', 'ruby', 'go', 'rust']
let g:go_metalinter_autosave=1
let g:go_highlight_types=1
let g:go_highlight_fields=1
let g:go_highlight_functions=1
let g:go_highlight_operators=1
let g:go_highlight_extra_types=1
let g:go_highlight_function_calls=1
let g:go_highlight_build_constraints=1

au BufNewFile,BufRead Jenkinsfile setf groovy
au BufNewFile,BufRead Containerfile setf dockerfile
au FileType asciidoc setlocal commentstring=//\ %s

nnoremap <Space> za
nnoremap <leader>b :bd<CR>
nnoremap <leader>, ,
nnoremap <leader>e :e **/
tnoremap <Esc> <C-\><C-n>
tnoremap <C-v><Esc> <Esc>
nnoremap yog :exe "set signcolumn=" .. (&signcolumn == "yes" ? "no" : "yes")<CR>
xnoremap <leader>wl :keepp s/\\\n//g<CR>
nnoremap <leader>wr :r! ssh workstation -q 
nnoremap <leader>wb :!sk flamel && rm -rf guides/tmp && flamel sg<CR>
xnoremap <silent> i* :<C-u>keepp normal! T*vt*<CR>
onoremap <silent> i* :<C-u>keepp normal! T*vt*<CR>
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
\    workspaceConfig: #{ python: #{ pythonPath: 'python' } }
\  },
\  #{
\    name: 'openscad',
\    filetype: ['openscad'],
\    path: 'openscad-lsp'
\  }
\])
