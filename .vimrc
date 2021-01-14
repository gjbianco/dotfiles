" auto install
if empty(glob('~/.vim/pack/minpac/opt/minpac/autoload/minpac/impl.vim'))
  silent !git clone https://github.com/k-takata/minpac.git
        \ ~/.vim/pack/minpac/opt/minpac
endif
if empty(glob('~/.vim/autoload/plugpac.vim'))
  silent !curl -fLo ~/.vim/autoload/plugpac.vim --create-dirs
        \ https://raw.githubusercontent.com/bennyyip/plugpac.vim/master/plugpac.vim
endif

call plugpac#begin()

Pack 'k-takata/minpac', {'type': 'opt'}

Pack 'neoclide/coc.nvim', {'branch': 'release'}

" themes
Pack 'morhetz/gruvbox'

" visual
Pack 'nathanaelkane/vim-indent-guides'
Pack 'airblade/vim-gitgutter'
" Pack 'itchyny/lightline.vim'
Pack 'itchyny/vim-gitbranch'

" navigation
Pack 'ap/vim-buftabline'
Pack 'tpope/vim-vinegar'
Pack 'tpope/vim-projectionist'
Pack 'kien/ctrlp.vim'
Pack 'ptzz/lf.vim'
" Pack 'iberianpig/ranger-explorer.vim'
Pack 'rbgrouleff/bclose.vim' " needed for ranger/lf
" Pack 'preservim/nerdtree'

Pack 'fatih/vim-go'

" javascript/frontend
Pack 'pangloss/vim-javascript'
Pack 'leafgarland/typescript-vim'
" Pack 'peitalin/vim-jsx-typescript'
Pack 'HerringtonDarkholme/yats.vim'
" Pack 'styled-components/vim-styled-components', { 'branch': 'main' }
" Pack 'jparise/vim-graphql'

" asciidoc
Pack 'habamax/vim-asciidoctor'

" general editing
Pack 'editorconfig/editorconfig-vim'
Pack 'godlygeek/tabular'

Pack 'junegunn/goyo.vim'
Pack 'junegunn/limelight.vim'

Pack 'prettier/vim-prettier', {
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
Pack 'tpope/vim-surround'
Pack 'tpope/vim-commentary'
Pack 'tpope/vim-repeat'
Pack 'tpope/vim-unimpaired'

call plugpac#end()

syntax on
set mouse=a
set number
" set relativenumber
set backspace=indent,eol,start

" MacOSX/Linux
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,node_modules,yarn.lock,package-lock.json

set linebreak
set autoindent
set tabstop=2
set shiftwidth=2
set smarttab
set expandtab

" Jenkinsfile VIM syntax highlighting
au BufNewFile,BufRead Jenkinsfile setf groovy

" begin custom statusline ------------------
function! StatuslineGit()
  let l:branchname = gitbranch#name()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

function! SubbedCWD()
  return substitute(getcwd(), $HOME, '~', '')
endfunction

set statusline=
set statusline+=%#PmenuSel# " blue
" set statusline+=%#DiffAdd# " green
set statusline+=%{StatuslineGit()} " seems to be an expensive call
set statusline+=%#StatusLineNC#
set statusline+=%{expand('%:t')}
set statusline+=\ %{coc#status()}
set statusline+=%=
set statusline+=\ %{SubbedCWD()}
set statusline+=\ %y    " filetype
set statusline+=\ %l:%c " lines:chars
set statusline+=\ 

" set noshowmode
" let g:lightline = {
"   \ 'colorscheme': 'srcery_drk',
"   \ 'active': {
"   \   'left': [ [ 'mode', 'paste' ],
"   \             [ 'gitbranch', 'readonly' ],
"   \             [ 'cwd' ] ],
"   \   'right': [ [],
"   \              [ 'lineinfo' ],
"   \              [ 'filetype' ] ]
"   \ },
"   \ 'component_function': {
"   \   'cocstatus': 'coc#status',
"   \   'gitbranch': 'gitbranch#name',
"   \   'cwd': 'getcwd'
"   \ },
" \ }

" end custom statusline ------------------

let mapleader = "," " set leader to space

" close all but current buffer
command! BufOnly silent! execute "%bd|e#|bd#"

" save to hastebin (requires haste-client)
command! Haste execute ":w !cat | haste"
command! HasteCopy silent! execute ":w !cat | haste | pbcopy"

" toggle hlsearch
nnoremap <leader>hl :set invhlsearch<CR>

" replace
nnoremap <leader>r :%s///g<Left><Left>

" make
nnoremap <leader>m :make<CR><CR>

" CtrlP
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)|node_modules$'

" netrw / vinegar
nnoremap <leader>n :Explore<CR>
" nnoremap <leader>n :Rexplore<CR>
" let g:netrw_liststyle = 3
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

" enable buftabline indicators
let g:buftabline_indicators = 1

" highlight TODO
augroup HiglightTODO
  autocmd!
  autocmd WinEnter,VimEnter * :silent! call matchadd('Todo', 'TODO', -1)
  autocmd WinEnter,VimEnter * :silent! call matchadd('Fixme', 'FIXME', -1)
  autocmd WinEnter,VimEnter * :silent! call matchadd('Note', 'NOTE', -1)
augroup END

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
  " Limelight
  set showtabline=0
endfunction
function ExitGoyo()
  " Limelight!
  set showtabline=2
  hi Normal guibg=NONE ctermbg=NONE
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
" autocmd BufNewFile,BufRead *.json set ft=javascript

set ssop-=options    " do not store global and local values in a session
set ssop-=folds      " do not store folds

nnoremap <leader>e :bnext<CR>
nnoremap <leader>w :bprev<CR>
"nnoremap <leader>q :bdelete<CR>
nnoremap <leader>q :bp<cr>:bd #<cr>

" terminal mode bindings
if has('nvim')
  tnoremap <Esc> <C-\><C-n>
  tnoremap <C-v><Esc> <Esc>
  " hightlight! link TermCursor Cursor
  " hightlight! TermCursorNC guibg=green guifg=white ctermbg=1 ctermfg=15
endif

" asciidoc config
function! AsciidoctorMappings()
  nnoremap <buffer> <leader>op :AsciidoctorOpenPDF<CR><CR>
  nnoremap <buffer> <leader>oh :AsciidoctorOpenHTML<CR><CR>
  nnoremap <buffer> <leader>ch :Asciidoctor2HTML<CR>
  compiler asciidoctor2pdf
endfunction

augroup asciidoctor
  au!
  au BufEnter *.adoc,*.asciidoc call AsciidoctorMappings()
augroup END

" enable if JS/TS syntax highlighting gets out of sync
" autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
" autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

" prettier command for coc
command! -nargs=0 Prettier :CocCommand prettier.formatFil

" coc settings
let g:coc_global_extensions = [
  \ 'coc-pairs',
  \ 'coc-prettier', 
  \ 'coc-json', 
  \ 'coc-emmet',
  \ 'coc-tsserver',
  \ 'coc-go',
  \ ]
  " \ 'coc-deno'

if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

nnoremap <silent> K :call CocAction('doHover')<CR>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>do <Plug>(coc-codeaction)
nmap <leader>rn <Plug>(coc-rename)

" begin coc readme settings ---------------
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
" set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif
set scl=no

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif
inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>cf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" end coc readme settings ------------------

" vim-go config
let g:go_auto_type_info = 1 " enable type near status
let g:go_code_completion_enabled = 0 " disable completion
let g:go_doc_keywordprg_enabled = 0  " disable |K| shortcut
" highlighting
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1

" ranger config
" nnoremap <Leader>n :RangerOpenCurrentDir<CR>
" nnoremap <Leader>f :RangerOpenProjectRootDir<CR>

" lf config
let g:lf_map_keys = 0
map <leader>n :Lf<CR>
map <leader>pn :LfWorkingDirectory<CR>
let g:lf_replace_netrw = 1 " open lf when vim opens a directory

" split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" colors
set background=dark
set t_Co=256
" fix spell colors for gruvbox
let g:gruvbox_guisp_fallback = "bg"
colorscheme gruvbox
hi Normal guibg=NONE ctermbg=NONE
