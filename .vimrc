if has('gui_running')
  set guifont=Consolas:h32
endif
if !has('gui_running')
  set t_Co=256
endif
set backspace=indent,eol,start

call plug#begin('~/.vim/plugged')
syntax on
set laststatus=2
set noshowmode
set number

    Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
    Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
    Plug 'sheerun/vim-polyglot'
    Plug 'itchyny/lightline.vim'
    Plug 'itchyny/vim-gitbranch'

set background=dark
colorscheme edge
let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name'
      \ },
      \ }
    map <C-\> :NERDTreeToggle<CR>
call plug#end()
