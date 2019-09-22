if has('gui_running')
  set guifont=Consolas:h32
endif
if !has('gui_running')
  set t_Co=256
endif
set backspace=indent,eol,start

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
Plug 'sheerun/vim-polyglot'
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'

" For fuzzy search file 
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
" For view git diff
Plug 'tpope/vim-fugitive'
call plug#end()




syntax on
set laststatus=2
set noshowmode
set number
set nobackup
set nowritebackup
set mouse=a " enable mouse for all mode
set noswapfile
set autoindent
set smartindent
set background=dark
colorscheme edge
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.json,*.css,*.scss,*.less,*.graphql Prettier
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

