" Leader
let mapleader = " "

scriptencoding utf-8
set encoding=utf-8

set backspace=2 " Backspace deletes like most programs in insert mode
set nocompatible " Use Vim settings, rather then Vi settings
set nobackup
set nowritebackup
set noswapfile " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler " show the cursor position all the time
set showcmd " display incomplete commands
set incsearch " do incremental searching
set laststatus=2 " Always display the status line
set autowrite " Automatically :write before running commands
set mouse=a

" Softtabs, 4 spaces
set softtabstop=4
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set cindent

execute pathogen#infect()

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

filetype on
filetype plugin indent on

augroup vimrcEx
  autocmd!

" For all text files set 'textwidth' to 78 characters.
  " autocmd FileType text setlocal textwidth=78

" When editing a file, always jump to the last known cursor position.
" Don't do it for commit messages, when the position is invalid, or when
" inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \ exe "normal g`\"" |
    \ endif

" Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile *.py set filetype=python
  autocmd BufRead,BufNewFile *.asm,.inc set filetype=asm_ca65
  autocmd BufEnter *.py set ai sw=4 ts=4 sta et fo=croql

" Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell

" Automatically wrap at 80 characters for Markdown
  " autocmd BufRead,BufNewFile *.md setlocal textwidth=80
augroup END

" Display extra whitespace
set list listchars=tab:»·,trail:·

" Color scheme
colorscheme badwolf
" set background=dark

" Numbers
set number
set numberwidth=5

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
set complete=.,w,t
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-n> <C-w>_
nnoremap <C-m> <C-w><bar><C-w>5<


" configure syntastic syntax checking to check on open as well as save
let g:syntastic_check_on_open=1

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif

nnoremap <leader>g :wa <bar> :make && make run <CR>
nnoremap <C-b> :wa <bar> :qa <CR>
nnoremap <silent> j gj
nnoremap <silent> k gk
inoremap { {<CR>}<Esc>O
inoremap {{ {
inoremap {} {}
inoremap ( ()<Left>
inoremap (( (
inoremap <expr> ) strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"

nnoremap H ^
nnoremap L g_

nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>f :TagbarToggle<CR>

function! PrettyTabs ()
  set nowrap
  set sidescrolloff=999
endfunction

nnoremap <leader>t :call PrettyTabs() <bar> :%!column -t -s '	' <CR>

" Escape special characters in a string for exact matching.
" This is useful to copying strings from the file to the search tool
" Based on this -
" http://peterodding.com/code/vim/profile/autoload/xolox/escape.vim
function! EscapeString (string)
  let string=a:string
"  Escape regex characters
  let string = escape(string, '^$.*\/~[]')
   " Escape the line endings
  let string = substitute(string, '\n', '\\n', 'g')
  return string
endfunction

" Get the current visual block for search and replaces
" This function passed the visual block through a string escape
" function
" Based on this -
"http://stackoverflow.com/questions/676600/vim-replace-selected-text/677918#677918
function! GetVisual() range
" Save the current register and clipboard
  let reg_save = getreg('"')
  let regtype_save = getregtype('"')
  let cb_save = &clipboard
  set clipboard&

" Put the current visual selection in the " register
  normal! ""gvy
  let selection = getreg('"')

" Put the saved registers and clipboards back
  call setreg('"', reg_save, regtype_save)
  let &clipboard = cb_save

"Escape any special characters in the selection
  let escaped_selection = EscapeString(selection)

  return escaped_selection
endfunction

vmap <C-r> <Esc>:%s/<c-r>=GetVisual()<cr>//gc<left><left><left>
vmap * <Esc>/<c-r>=GetVisual()<cr><CR>

let python_version_2 = 1
let python_highlight_all = 1
"let g:AutoComplPop_CompleteoptPreview = 1

autocmd vimenter * NERDTree
autocmd vimenter * wincmd l
autocmd vimenter * Tagbar
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"python from powerline.vim import setup as powerline_setup
"python powerline_setup()
"python del powerline_setup

set hidden
nnoremap <leader>b :bnext<CR>
nnoremap <leader>v :bprev<CR>
nnoremap <leader>c :bn<CR>:bd#<CR>
