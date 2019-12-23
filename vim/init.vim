call plug#begin('~/.config/nvim/plugged')

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'sheerun/vim-polyglot'
Plug 'itchyny/lightline.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" theme
Plug 'arcticicestudio/nord-vim'
" Plug 'tyrannicaltoucan/vim-quantum'
Plug 'pangloss/vim-javascript'
Plug 'itchyny/vim-gitbranch'
" For fuzzy search file 
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
" For view git diff
Plug 'tpope/vim-fugitive'
" EditorConfig
Plug 'editorconfig/editorconfig-vim'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
call plug#end()



let g:gitgutter_sign_allow_clobber = 1
syntax on
set signcolumn=yes
set updatetime=10
set encoding=UTF-8
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
set guicursor=
set background=dark
" remove delay when change mode
set ttimeout
set ttimeoutlen=100
set termguicolors
" Better display for messages
set cmdheight=2
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

colorscheme nord
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.json,*.css,*.scss,*.less,*.graphql Prettier
let g:lightline = {
      \ 'colorscheme': 'nord',
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
" NERDTree config
let NERDTreeMinimalUI=1



" gitgutter 


" Remap key 
let mapleader=" "
inoremap jk <ESC>
nnoremap ; :
map <C-\> :NERDTreeToggle<CR>
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>s :w<CR>
" Split screen 
nnoremap <Leader>v :vsplit<CR>
nnoremap <Leader>b :split<CR>
" Ripgrep search global
nnoremap <Leader>rg :Rg<CR>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" keyblind In insert mode move normally by using Ctrl
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
inoremap <C-q> <Home>
inoremap <C-p> <End>
inoremap <C-w> <C-o>w
inoremap <C-b> <C-o>b

" keyblind In Command mode move normally by using Ctrl
cnoremap <C-h> <Left>
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
cnoremap <C-l> <Right>
" clear hight light 

" map key for coc 
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"\
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
