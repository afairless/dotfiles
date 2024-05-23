" install vim-plug:
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

" load plug-ins within Vim:
" :PlugInstall

call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree'
Plug 'python-mode/python-mode'
Plug 'davidhalter/jedi-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'itchyny/lightline.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'jpalardy/vim-slime'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'tpope/vim-commentary'
"Plug 'puremourning/vimspector'

call plug#end()


" set text paste destination for 'vim-slime' plugin
" documentation at:
"   https://github.com/jpalardy/vim-slime
let g:slime_target = "vimterminal"


" Lets the 'F4' key toggle NerdTree on and off
map <F4> :NERDTreeToggle<CR>
map <Space>e :NERDTreeToggle<CR>


" Toggles among showing absolute line numbers, relative line numbers, and none
function! LineToggle()
  if(&relativenumber == 1)
    set norelativenumber | set number!
  elseif(&number == 1)
    set relativenumber
  else
    set number!
  endif
endfunc
nmap <F1> :call LineToggle()<cr>


" Allows moving out of Vim terminal to other panes
tmap <C-j> <C-W>j
tmap <C-k> <C-W>k
tmap <C-h> <C-W>h
tmap <C-l> <C-W>l


" Removes PyLint messages on left margin of code
nmap <F2> :sign unplace *<cr> <cr>
" Alternative:  this command permanently disables PyLint messages on left margin of code:
" let g:pymode_lint_signs = 0

" Removes PyLint messages on left margin of code
nmap <F3> :only <cr>

" Replaces tabs with spaces
set tabstop=4
"set softtabstop=4
set shiftwidth=4
"set shiftround
set expandtab

" Python-mode configuration below:
" Activate rope
" Keys:
" K             Show python docs
" <Ctrl-Space>  Rope autocomplete
" <Ctrl-c>g     Rope goto definition
" <Ctrl-c>d     Rope show documentation
" <Ctrl-c>f     Rope find occurrences
" <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled)
" [[            Jump on previous class or function (normal, visual, operator modes)
" ]]            Jump on next class or function (normal, visual, operator modes)
" [M            Jump on previous class or method (normal, visual, operator modes)
" ]M            Jump on next class or method (normal, visual, operator modes)
let g:pymode_rope = 0

" Documentation
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'

"Linting
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
" Auto check on save
let g:pymode_lint_write = 1

" Support virtualenv
let g:pymode_virtualenv = 1

" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_bind = '<leader>b'

" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Don't autofold code
let g:pymode_folding = 1
