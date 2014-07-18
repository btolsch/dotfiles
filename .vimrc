autocmd! bufwritepost .vimrc source %

set timeoutlen=150 ttimeoutlen=0

filetype plugin on
set omnifunc=syntaxcomplete#Complete

nnoremap j gj
nnoremap k gk

set tabstop=4
set shiftwidth=4
nnoremap <silent> <A-h> :tabprevious<CR>
nnoremap <silent> <A-j> :tabfirst<CR>
nnoremap <silent> <A-k> :tablast<CR>
nnoremap <silent> <A-l> :tabnext<CR>
" Alt typically emulated as <Esc>
nnoremap <silent> <Esc>h :tabprevious<CR>
nnoremap <silent> <Esc>j :tabfirst<CR>
nnoremap <silent> <Esc>k :tablast<CR>
nnoremap <silent> <Esc>l :tabnext<CR>
nnoremap <C-A-n> :tabnew<Space>
nnoremap <Esc><C-n> :tabnew<Space>

" Insert home key motion with Alt
inoremap <Esc>h <Esc>i
inoremap <Esc>j <Esc>jli
inoremap <Esc>k <Esc>kli
inoremap <Esc>l <Esc>lli

" map <C-k> <C-W>k
" map <C-j> <C-W>j
noremap <A-n> <C-w><
noremap <A-m> <C-w>>
noremap <Esc>n <C-w><
noremap <Esc>m <C-w>>
noremap + <C-W>+
noremap - <C-W>-
noremap = <C-W>=

" filetype plugin indent on
syntax on

" set foldmethod=indent
set foldmethod=syntax
set foldnestmax=1
nnoremap <space> za

" fix backspace
set bs=indent,eol,start

let mapleader = ","

" Visual mode sort
vnoremap <Leader>s :sort<CR>

" Visual mode search
vnoremap // y/<C-r>"<CR>

" Better visual mode block indentation
vnoremap > >gv
vnoremap < <gv

" Visual copy
vnoremap <C-c> "+y

" Normal copy-paste
nnoremap <C-c> "+y
nnoremap <C-v> "+p

" Show whitespace
" MUST be inserted BEFORE the colorscheme command
" autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
" au InsertLeave * match ExtraWhitespace /\s\+$/
highlight ExtraWhitespace ctermbg=red guibg=red

" set nowrap
set number
set t_Co=256
" set tw=79
" set fo-=t
set colorcolumn=80
highlight ColorColumn ctermbg=234

set hlsearch
set incsearch
set ignorecase
noremap <silent> <Leader>; :nohl<CR>

" Line wrapping
vmap Q gq
nmap Q gqap

set nobackup
set nowritebackup
set noswapfile

" Setup pathogen for plugins
" mkdir -p ~/.vim/autoload ~/.vim/bundle
" curl -so ~/.vim/autoload/pathogen.vim https://raw.github.com/tpope/vim-pathogen/HEAD/autoload/pathogen.vim
" Install plugins to ~/.vim/bundle/
call pathogen#infect()

" Powerline
" yaourt -S python-powerline-git
let $PYTHONPATH='/usr/lib/python3.4/site-packages'
set laststatus=2
set noshowmode
set encoding=utf-8
set term=xterm-256color
set termencoding=utf-8
set guifont=Inconsolata\ for\ Powerline:h15
set t_Co=256
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup
" let g:Powerline_symbols = 'fancy'

" CtrlP
" git clone https://github.com/kien/ctrlp.cim.git
let g:ctrlp_max_height = 30
set wildignore+=*.pyc
set wildignore+=*.o

" python-mode
" git clone https://github.com/klen/python-mode
" map <Leader>g :call RopeGotoDefinition()<CR>
" let ropevim_enable_shortcuts = 1
" let g:pymode_rope_goto_def_newwin = "vnew"
" let g:pymode_rope_extended_complete = 1
" let g:pymode_breakpoint = 0
" let g:pymode_syntax = 1
" let g:pymode_syntax_builtin_objs = 0
" let g:pymode_syntax_builtin_funcs = 0
" map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>

" python folding
" set nofoldenable
