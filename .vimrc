syntax on

let g:syntastic_auto_loc_list=0
let g:syntastic_enable_signs=1
set mouse=a

filetype off

" Set up Vundle
" This also includes all of the plugins I use
"
" Run :BundleInstall to install all of the plugins
source ~/.vim/.vundle

set autoread
set autowrite

set backspace=2 "Make backspace work as expected on Mac OS X
set autoindent  "Auto Indent code - This simply retains indentation level

" General indentation settings
" 
" Note that these vary from language to language
set tabstop=2   "Set space width of tabs
set softtabstop=2
set sw=2
set expandtab

set splitright  "By default, split to the right
set splitbelow
set number      "Add line numbers
set ruler       "Display Cursor Position
set title       "Display filename in titlebar

set backupdir=/Users/jlfwong/.vim/backup/,.

set incsearch   "Display search resultings as you type
set ignorecase
set smartcase
set wildmenu

filetype plugin on
filetype indent off

let mapleader=","
let maplocalleader=","

" Round indentation to multiple of shitwidth
set shiftround

" let [jk] go down and up by display lines instead of real lines. Let g[jk]
" do what [jk] normally does
nnoremap k gk
nnoremap j gj
nnoremap gk k
nnoremap gj j

"Map Semicolon to : for faster command execution
nmap ; :

"] and ^] switch between tabs
nmap ] :tabNext<CR>

"\ and | switch between split screens
nmap \ <C-w><C-w>
nmap \| <C-w>W

"NERDTree
map <Leader>n :NERDTreeToggle<CR>

"Gundo
nmap <Leader>u :GundoToggle<CR>

"Make
nmap <Leader>m :make<CR>

",p copies the current filepath
nmap <Leader>p :!echo `pwd`/% \| pbcopy<CR><CR>

" Tabularize
vmap <Leader>t :Tabularize /

"OmniCompletion
set completeopt=longest,menuone
set omnifunc=syntaxcomplete#Complete
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"

"LANGUAGE SPECIFIC COMMANDS
"
" For all languages:
"  <Leader>c - Syntax Check / Compile
"  <Leader>r - Execute
"
" See ftplugin/*.vim
