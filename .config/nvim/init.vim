if has('nvim')
  call plug#begin('~/.local/share/nvim/plugged')
else
  call plug#begin('~/.vim/plugged')
endif
" general
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-surround'
Plug 'altercation/vim-colors-solarized'
Plug 'easymotion/vim-easymotion'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'christoomey/vim-tmux-navigator'
Plug 'pprovost/vim-ps1'
Plug 'liuchengxu/vista.vim'
Plug 'airblade/vim-gitgutter'
Plug 'martinda/jenkinsfile-vim-syntax'
Plug 'vimwiki/vimwiki'

" completion
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tjdevries/coc-zsh'

" javascript
Plug 'pangloss/vim-javascript'
Plug 'posva/vim-vue'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'leafgarland/typescript-vim'
Plug 'mxw/vim-jsx'
Plug 'mustache/vim-mustache-handlebars'
Plug 'wokalski/autocomplete-flow'
call plug#end()

" vimwiki
let g:vimwiki_list = [{'syntax': 'markdown', 'ext': '.md'}]
nmap gl<Space> <Plug>VimwikiToggleListItem

" Set leader to comma
let mapleader=","

" vim-javascript
" ==============
let g:javascript_plugin_flow = 1

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
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.vue,*.html PrettierAsync

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
map <F5> :NERDTreeToggle<CR>
map <F4> :NERDTreeToggle<CR>
map <F3> :NERDTreeFocus<CR>
" disable arrows
let g:NERDTreeDirArrowExpandable = "\u00a0"
let g:NERDTreeDirArrowCollapsible = "\u00a0"

" vim-devicons
" ============
let g:WebDevIconsNerdTreeBeforeGlyphPadding = ""
let g:DevIconsEnableFoldersOpenClose = 1

" vim-easymotion
" ==============
map <Leader> <Plug>(easymotion-prefix)
let g:EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'

" ultisnips
" =========
let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"

" vista.vim
" =========
"let g:vista_default_executive = "coc"

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

" Tab settings
set expandtab
set shiftwidth=2
set softtabstop=2

" Colors
set background=dark
colorscheme solarized
hi SignColumn ctermbg=None

" General
set nu 
set hidden
set nobackup
set nowritebackup
set pastetoggle=<F11>
set mouse+=a
set colorcolumn=81
set cmdheight=2
set laststatus=2
set confirm
set ignorecase
set smartcase
set wildmode=longest:list,full
set showcmd
set ruler
set autoread
set autowrite
set visualbell
set t_vb=
set splitbelow
set splitright
set updatetime=300
set shortmess+=c

" CoC config
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

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

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-D for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

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

" coc-nvim colors
" ===============
hi CocFloating ctermbg=0
hi CoCMenuSel ctermbg=14 ctermfg=8

" Golang
" ======
autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
autocmd FileType go setlocal noexpandtab
autocmd FileType go setlocal tabstop=2
