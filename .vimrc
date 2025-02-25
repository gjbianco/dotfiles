if empty(glob('~/.vim/pack/minpac/opt/minpac/autoload/minpac/impl.vim'))
  silent !git clone https://github.com/k-takata/minpac.git ~/.vim/pack/minpac/opt/minpac
endif
packadd minpac
call minpac#init()
call minpac#add('k-takata/minpac', {'type': 'opt'})
call minpac#add('morhetz/gruvbox')
call minpac#add('tpope/vim-repeat')
call minpac#add('tpope/vim-sensible')
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-unimpaired')
call minpac#add('yegappan/lsp')
call minpac#add('ap/vim-buftabline')
call minpac#add('kana/vim-smartinput')
call minpac#add('prettier/vim-prettier')
call minpac#add('airblade/vim-gitgutter')
call minpac#add('jeetsukumaran/vim-filebeagle')
call minpac#add('gjbianco/vim-asciidoc-syntax')
call minpac#add('madox2/vim-ai')

let g:markdown_fenced_languages=['html', 'js=javascript', 'ruby', 'go', 'rust']
let g:prettier#autoformat_require_pragma=0
let g:prettier#autoformat=1
let g:filebeagle_show_parent=0
let g:filebeagle_check_gitignore=1
let g:gruvbox_guisp_fallback="bg"
let g:buftabline_indicators=1

let complete_engine_config = {
\  "engine": "complete",
\  "options": {
\    "model": "granite-3-8b-instruct",
\    "endpoint_url": "https://granite-3-8b-instruct-maas-apicast-production.apps.prod.rhoai.rh-aiservices-bu.com:443/v1/completions",
\    "max_tokens": 15,
\    "max_completion_tokens": 15,
\    "temperature": 0.7,
\    "selection_boundary": "",
\    "token_file_path": "~/.config/editor1.token",
\    "stream": 0,
\    "enable_auth": 1,
\  },
\  "ui": {
\    "paste_mode": 1,
\  },
\ }
let g:vim_ai_complete = complete_engine_config
let g:vim_ai_edit = complete_engine_config
let g:vim_ai_chat = {
\  "engine": "chat",
\  "options": {
\    "model": "granite-3-8b-instruct",
\    "endpoint_url": "https://granite-3-8b-instruct-maas-apicast-production.apps.prod.rhoai.rh-aiservices-bu.com:443/v1/chat/completions",
\    "max_tokens": 1000,
\    "max_completion_tokens": 1000,
\    "temperature": 0.7,
\    "selection_boundary": "",
\    "token_file_path": "~/.config/editor1.token",
\    "stream": 0,
\    "enable_auth": 1,
\  },
\  "ui": {
\    "paste_mode": 1,
\  },
\ }
nnoremap <leader>v :AI<CR>
xnoremap <leader>v :AI<CR>

au BufNewFile,BufRead Jenkinsfile setf groovy
au BufNewFile,BufRead Containerfile setf dockerfile
au FileType asciidoc setlocal commentstring=//\ %s

colorscheme gruvbox
set background=dark
set mouse=a
set scl=no
set autoindent
set tabstop=2
set shiftwidth=2
set expandtab
set ignorecase
set smartcase
set updatetime=300 " update git column faster
set linebreak      " handle line wrapping better
set hidden
set noswapfile
set ttyfast
set statusline=%m%f%=%y\ %l:%c
set wildignore+=node_modules/**,.git/**
let mapleader=","

nnoremap <Space> za
nnoremap <leader>b :bd<CR>
nnoremap <leader>, ,
nnoremap <leader>e :e **/
nnoremap yog :exe "set signcolumn=" .. (&signcolumn == "yes" ? "no" : "yes")<CR>
xnoremap <leader>wl :keepp s/\\\n//g<CR>
nnoremap <leader>wr :r! ssh workstation -q 
nnoremap <leader>wb :!sk flamel && rm -rf guides/tmp && flamel sg<CR>
nnoremap <leader>wg :!rsync -r classroom/grading/ workstation:grading --delete<CR>
xnoremap <silent> i* :<C-u>keepp normal! T*vt*<CR>
onoremap <silent> i* :<C-u>keepp normal! T*vt*<CR>

nnoremap K :LspHover<CR>
nnoremap <leader>d :LspPeekDefinition<CR>
nnoremap <leader>g :LspGotoDefinition<CR>
nnoremap <leader>a :LspCodeAction<CR>
nnoremap <leader>e :LspDiagCurrent<CR>
au User LspSetup call LspOptionsSet(#{
\  autoComplete: v:false,
\  omniComplete: v:true,
\  completionMatcher: 'fuzzy',
\  diagVirtualTextAlign: 'below',
\  hideDisabledCodeActions: v:true,
\  ignoreMissingServer: v:true,
\  noNewlineInCompletion: v:true,
\  semanticHighlight: v:true,
\  showDiagWithSign: v:false,
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
\    name: 'ruff',
\    filetype: ['python'],
\    path: 'ruff',
\    args: ['server']
\  },
\  #{
\    name: 'openscad',
\    filetype: ['openscad'],
\    path: 'openscad-lsp'
\  }
\])
au BufWritePre *.py :LspFormat
