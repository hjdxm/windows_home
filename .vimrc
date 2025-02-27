set nocompatible
syntax on
filetype plugin indent on
set number relativenumber
set tabstop=4 shiftwidth=4 expandtab
set cursorline
set smartindent autoindent cindent
set ignorecase smartcase 
set hlsearch
set wildmenu
set hidden
set showmatch
set foldmethod=indent

let mapleader=' '
nnoremap <leader>p :set paste!<CR>
nnoremap <leader>l :set hlsearch!<CR>
nnoremap <leader>F :CocCommand editor.action.formatDocument<CR>
nnoremap <leader>e :NERDTreeToggle<CR>
command! -nargs=1 Vr vertical resize <args><CR>
command! -nargs=1 Hr resize <args><CR>

" Plug configuration
" ==================
" ==================
call plug#begin()

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'img-paste-devs/img-paste.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'preservim/nerdtree'
Plug 'Glench/Vim-Jinja2-Syntax'

call plug#end()

" nerdtree configuration
" ==================
" ==================
Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

" markdown_preview configuration
" ==================
" ==================
"nmap <C-s> <Plug>MarkdownPreview
"nmap <M-s> <Plug>MarkdownPreviewStop
nmap <C-p> <Plug>MarkdownPreviewToggle

" img_paste configuration
" ==================
" ==================
autocmd FileType markdown nmap <buffer><silent> <leader>g :call mdip#MarkdownClipboardImage()<CR>
" there are some defaults for image directory and image name, you can change
" them
let g:mdip_imgdir = 'md_img'
let g:mdip_imgname = 'image'


" Coc configuration
" =================
" =================

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>
" coc.nvim 插件配置，绑定 <C-k> 键触发参数提醒
inoremap <silent><expr> <C-k> coc#refresh()


function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
" autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocm
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end


" font color configuration
" ======================
" ======================
colorscheme desert
set guifont=Consolas:h16

highlight Conceal guifg=#AFEEEE
