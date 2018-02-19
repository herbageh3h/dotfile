set nocompatible
filetype plugin indent on
syntax enable

set autoread
set ruler
set encoding=utf8
set history=1000
set path=$PWD/**

set shiftround
set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set number
set relativenumber

set nobackup
set nowb
set noswapfile

set so=7
set backspace=eol,start,indent

set ignorecase
set smartcase
set nohlsearch
set incsearch

set visualbell t_vb=
set novisualbell

set wildmenu
set wildignore+=node_modules/*,bower_components/*,.git/*
set wildignore+=*.class

colorscheme monokai

" abbrev
iabbrev mymail herbage_h2h@sina.com

" keybindings 
let mapleader="\<space>"
let maplocalleader="\\"

noremap q: :q

vnoremap <silent> <C-c> :<CR>:let @a=@" \| execute "normal! vgvy" \| let res=system("pbcopy", @") \| let @"=@a<CR>

noremap <Leader>. :cd %:p:h<cr>:pwd<cr>
nnoremap <M-j> mz:m+<cr>`z
nnoremap <M-k> mz:m-2<cr>`z
vnoremap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vnoremap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

noremap <C-h> <C-W>h
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-l> <C-W>l

nnoremap <Leader>vf :find $MYVIMRC<CR>
nnoremap <Leader>vs :source $MYVIMRC<CR>

inoremap jk <esc>

" netrw
let g:netrw_winsize=-40
let g:netrw_liststyle=3


" plugin manager
execute pathogen#infect()

" plugin matchit
runtime! macros/matchit.vim

" plugin denite
call denite#custom#var('grep', 'command', ['rg'])
call denite#custom#var('grep', 'default_opts',
      \ ['--hidden', '--vimgrep', '--no-heading', '-S'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

"call denite#custom#var('file_rec', 'command', ['rg', '--files', '--glob', '!node_modules'])

nnoremap <leader>f :CtrlP<CR>
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>r :CtrlPMRU<CR>
nnoremap <leader>c :<C-u>Denite history:cmd<CR>
nnoremap <leader>s :<C-u>Denite grep:.<CR>

" CtrlP
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" plugin vim-javacomplete
autocmd FileType java setlocal omnifunc=javacomplete#Complete

nnoremap <silent> <leader>= :Neoformat<CR>

" plugin tagbar
let g:tagbar_left = 1
nnoremap <silent> <leader>t :TagbarToggle<CR>

" helper functions
function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" allows cursor change in tmux mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
