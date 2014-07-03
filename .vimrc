autocmd! bufwritepost .vimrc source %

nnoremap j gj
nnoremap k gk

set tabstop=4
set shiftwidth=4
nnoremap <silent> th :tabprevious<CR>
nnoremap <silent> tj :tabfirst<CR>
nnoremap <silent> tk :tablast<CR>
nnoremap <silent> tl :tabnext<CR>
nnoremap tn :tabnew<Space>
nnoremap td :tabdo<Space>

" map <silent> <C-k> <C-W>k
" map <silent> <C-j> <C-W>j
map <silent> + <C-W>+
map <silent> - <C-W>-
map <silent> = <C-W>=

" filetype off
" filetype plugin indent on
" syntax on

" fix backspace
set bs=2

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

" set nowrap
set number
" set tw=79
" set fo-=t
" set colorcolumn=80
" highlight ColorColumn ctermbg=1

set hlsearch
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
