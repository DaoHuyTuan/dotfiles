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
" EditorConfig
Plug 'editorconfig/editorconfig-vim'
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
set nojoinspaces
set nowrap
set cindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround
set expandtab
set hidden
set background=dark
" remove delay when change mode
set ttimeout
set ttimeoutlen=10
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
      if has('gui_running')
  set guifont=Consolas:h32
endif
if !has('gui_running')
  set t_Co=256
endif
set backspace=indent,eol,start

" Remap key 

let mapleader=" "
map <C-\> :NERDTreeToggle<CR>
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>s :w<CR>
" Tab controll
nnoremap <Leader>r :tabn<CR>
nnoremap <Leader>u :tabp<CR>
nnoremap <Leader>x :tabclose<CR>
" Split screen 
nnoremap <Leader>v :vsplit<CR>
nnoremap <Leader>b :split<CR>
" Ripgrep search global
nnoremap <Leader>rg :Rg<CR>
