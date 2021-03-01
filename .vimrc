" auto install minpac
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
Pack 'editorconfig/editorconfig-vim'

" visual
Pack 'morhetz/gruvbox'
Pack 'nathanaelkane/vim-indent-guides'
Pack 'airblade/vim-gitgutter'
Pack 'itchyny/vim-gitbranch'
Pack 'junegunn/goyo.vim'
Pack 'junegunn/limelight.vim'

" navigation
Pack 'ap/vim-buftabline'
Pack 'kien/ctrlp.vim'
Pack 'ptzz/lf.vim', {'rev': 'v1.3~1'}
Pack 'rbgrouleff/bclose.vim' " required for LF

" all hail Pope Tim
Pack 'tpope/vim-surround'
Pack 'tpope/vim-commentary'
Pack 'tpope/vim-repeat'
Pack 'tpope/vim-unimpaired'
Pack 'tpope/vim-fugitive'
" Pack 'tpope/vim-projectionist'

" language-specific plugins
Pack 'fatih/vim-go'
Pack 'habamax/vim-asciidoctor'
Pack 'pangloss/vim-javascript'
Pack 'leafgarland/typescript-vim'
Pack 'HerringtonDarkholme/yats.vim'
call plugpac#end()

syntax on
set mouse=a
set number
set backspace=indent,eol,start
set linebreak
set autoindent
set tabstop=2
set shiftwidth=2
set smarttab
set expandtab
set ssop-=options " do not store global and local values in a session
set ssop-=folds   " do not store folds
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,node_modules,yarn.lock,package-lock.json " MacOSX/Linux

" custom type remappings
au BufNewFile,BufRead Jenkinsfile setf groovy
au BufNewFile,BufRead *.toml setf config
au BufNewFile,BufRead Containerfile setf Dockerfile

let mapleader = "," " set leader to space

" custom functions/commands
command! BufOnly silent! execute "%bd|e#|bd#" " close all but current buffer
function! ToggleSignColumn()
	if(&signcolumn == "no")
		set signcolumn=yes
	else
		set signcolumn=no
	endif
endfunction

" custom mappings
nmap git :G
map <leader>n :Lf<CR>
map <leader>pn :LfWorkingDirectory<CR>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <leader>e :bnext<CR>
nnoremap <leader>w :bprev<CR>
nnoremap <leader>q :bp<cr>:bd #<cr>
nnoremap <leader>s :call ToggleSignColumn()<CR>
nnoremap <leader>r :%s///g<Left><Left>
nnoremap <leader>m :make<CR><CR>
nnoremap <leader>hl :set invhlsearch<CR>
nnoremap <leader>t :IndentGuidesToggle<CR>
nnoremap <leader>g :Goyo<CR>
nnoremap <leader>l :Limelight!!<CR>

" terminal mode bindings
if has('nvim')
  tnoremap <C-v><Esc> <Esc>
endif

" custom autocommands
autocmd! User GoyoEnter call EnterGoyo()
autocmd! User GoyoLeave call ExitGoyo()
augroup HiglightTODO
  autocmd!
  autocmd WinEnter,VimEnter * :silent! call matchadd('Todo', 'TODO', -1)
  autocmd WinEnter,VimEnter * :silent! call matchadd('Fixme', 'FIXME', -1)
  autocmd WinEnter,VimEnter * :silent! call matchadd('Note', 'NOTE', -1)
augroup END

" plugin config
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)|node_modules$'
let g:buftabline_indicators = 1
let g:go_auto_type_info = 1 " enable type near status
let g:go_code_completion_enabled = 0 " disable completion
let g:go_doc_keywordprg_enabled = 0  " disable |K| shortcut
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1
let g:lf_map_keys = 0
let g:lf_replace_netrw = 1 " open lf when vim opens a directory
let g:goyo_height = '95%'
let g:limelight_conceal_ctermfg = 'darkgrey'
let g:coc_global_extensions = [
  \ 'coc-pairs',
  \ 'coc-prettier', 
  \ 'coc-json', 
  \ 'coc-emmet',
  \ 'coc-tsserver',
  \ 'coc-go',
  \ ]

" prettier command for coc
command! -nargs=0 Prettier :CocCommand prettier.formatFil
if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif
if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

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

" asciidoc config
function! AsciidoctorMappings()
  nnoremap <buffer> <leader>op :AsciidoctorOpenPDF<CR><CR>
  compiler asciidoctor2pdf
endfunction
augroup asciidoctor
  au!
  au BufEnter *.adoc,*.asciidoc call AsciidoctorMappings()
augroup END

" handle colors different in vimdiff
if &diff
  " colorscheme evening
  highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
  highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
  highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
  highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red
endif

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
set statusline+=%{StatuslineGit()}
set statusline+=%#StatusLineNC#
set statusline+=%{expand('%:t')}
set statusline+=\ %{coc#status()}
set statusline+=%=
set statusline+=\ %{SubbedCWD()}
set statusline+=\ %y    " filetype
set statusline+=\ %l:%c " lines:chars
set statusline+=\ 

" end custom statusline ------------------

" begin coc readme settings ---------------
set hidden
set nobackup
set nowritebackup
set updatetime=300
set shortmess+=c

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

" coc mappings
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>ac  <Plug>(coc-codeaction)
nmap <leader>cf  <Plug>(coc-fix-current)
nmap <leader>rn <Plug>(coc-rename)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
nnoremap <silent> K :call <SID>show_documentation()<CR>
" end coc readme settings ------------------

" colors
set background=dark
set t_Co=256
let g:gruvbox_guisp_fallback = "bg" " fix spell colors for gruvbox
colorscheme gruvbox
hi Normal guibg=NONE ctermbg=NONE
