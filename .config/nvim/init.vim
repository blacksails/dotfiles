if has('nvim')
  call plug#begin('~/.local/share/nvim/plugged')
else
  call plug#begin('~/.vim/plugged')
endif
" general
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'altercation/vim-colors-solarized'
Plug 'easymotion/vim-easymotion'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'majutsushi/tagbar'
Plug 'jwilm/i3-vim-focus'
Plug 'christoomey/vim-tmux-navigator'
Plug 'darfink/vim-plist'
Plug 'hashivim/vim-vagrant'
Plug 'rodjek/vim-puppet'

" completion
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" javascript
Plug 'pangloss/vim-javascript'
Plug 'posva/vim-vue'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'leafgarland/typescript-vim'
Plug 'mxw/vim-jsx'
Plug 'flowtype/vim-flow', { 'do': 'npm install -g flow-bin', 'for': ['javascript'] }
Plug 'mustache/vim-mustache-handlebars'
Plug 'wokalski/autocomplete-flow'

" golang
Plug 'zchee/deoplete-go', { 'do': 'make'}
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }

" elixir
Plug 'elixir-editors/vim-elixir'
Plug 'slashmili/alchemist.vim'
call plug#end()

" Set leader to comma
let mapleader=","

" vim-javascript
" ==============
let g:javascript_plugin_flow = 1

" vim-flow
" ========
let g:flow#autoclose = 1

" vim-jsx
" =======
let g:jsx_ext_required = 0

" vim-prettier
" ============
let g:prettier#autoformat = 0
let g:prettier#config#single_quote = 'false'
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#jsx_bracket_same_line = 'false'
let g:prettier#config#arrow_parens = 'avoid'
let g:prettier#config#trailing_comma = 'none'
let g:prettier#config#parser = 'babylon'
let g:prettier#exec_cmd_path = '~/.local/share/nvim/plugged/vim-prettier/node_modules/prettier/bin-prettier.js'
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.html PrettierAsync

" vim-airline
" ===========
let g:airline_powerline_fonts = 1

" nerdtree
" ========
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = ['\.sw.$','^\.git$','.DS_Store']
let g:NERDTreeWinPos = 'left'
"autocmd StdinReadPre * let s:std_in=1 " start nerdtree automatically
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <F5> :NERDTreeToggle <BAR> :TagbarToggle<CR>
map <F4> :NERDTreeToggle<CR>
map <F3> :NERDTreeFocus<CR>

" tagbar
" ======
let g:tagbar_left = 0
let g:tagbar_vertical = 40
let g:tagbar_compact = 1
let g:tagbar_iconchars = ['▸', '▾']
let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent'
        \ }

" deoplete
" ========
let g:deoplete#enable_at_startup = 1

" i3-vim-focus / split navigation
" ==================
map gwl :call Focus('right', 'l')<CR>
map gwh :call Focus('left', 'h')<CR>
map gwk :call Focus('up', 'k')<CR>
map gwj :call Focus('down', 'j')<CR>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" vim-easymotion
" ==============
map <Leader> <Plug>(easymotion-prefix)
let g:EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'

" ctrlp
" =====
let g:ctrlp_custom_ignore = 'node_modules'

" ultisnips
" =========
let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

" vim-go
" ======
" tabsettings
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

" replace gofmt with goimports
let g:go_fmt_command = "goimports"

" lint go files on save
let g:go_metalinter_autosave = 1

" only use quickfix list
"let g:go_list_type = "quickfix"

" Configure highlights
let g:go_highlight_types = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1

" mappings
autocmd FileType go nmap <C-n> :lnext<CR>
autocmd FileType go nmap <C-p> :lprevious<CR>
autocmd FileType go nmap <leader>r <Plug>(go-run)
autocmd FileType go nmap <leader>t <Plug>(go-test)
autocmd FileType go nmap <Leader>i <Plug>(go-info)
autocmd FileType go nmap <Leader>b <Plug>(go-build)
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#cmd#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction
autocmd FileType go nmap <leader>m :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <leader>c <Plug>(go-coverage-toggle)
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

" Colors
set background=light
colorscheme solarized
hi Normal ctermbg=NONE

" Vim GUI
set guifont=Hack:h12
set linespace=2
set guioptions=

" Line numbers
set nu 

" Two rows command height
set cmdheight=2

" Confirm instead of failing
set confirm

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Use wildmenu for cmdline completion
set wildmode=longest:list,full

" Show commands
set showcmd

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Always display the status line, even if only one window is displayed
set laststatus=2

" Enable multiple files open at the same time
set hidden

" Enable autoread so changes to files are rendered instantly
set autoread

" Use visual bell instead of beeping when doing something wrong
set visualbell
" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=

" Open new split panes to right and bottom
set splitbelow
set splitright

" Automatically save files when calling make
set autowrite

" Tab settings
set expandtab
set shiftwidth=2
set softtabstop=2

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

" Toggle paste mode
set pastetoggle=<F11>

set mouse+=a

" Show column 80
set colorcolumn=81

set titlestring=VIM
