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
" For all languages:
"  <Leader>c - Syntax Check / Compile
"  <Leader>r - Execute

function! FileWOExt()
	"Returns the filename with no extension
	return substitute(@%, '\.[^\.]*$','','')
endfunction

"VimRC
function! EnterVimRC()
	" Both <Leader>c and <Leader>r are used to be consistent
	map <buffer> <Leader>c :w<CR>:so %
	map <buffer> <Leader>r :w<CR>:so %
	au BufWritePost <buffer> so %
endfunction
au FileType vim call EnterVimRC()

"Python
function! EnterPython()
	"Yes, I see that <Leader>c and <Leader>r do the same
	" thing. It'll stay that way until python
	" introduces a nice syntax-only flag
  set ts=4
  set sw=4
  set sts=4
	map <buffer> <Leader>c :w<CR>:!clear;python %
	map <buffer> <Leader>r :w<CR>:!clear;python %
  setlocal omnifunc=pysmell#Complete
endfunction
au FileType python call EnterPython()

"PHP
function! EnterPhp()
	map <buffer> <Leader>c :w<CR>:!clear;php -l %
	map <buffer> <Leader>r :w<CR>:!clear;php %
endfunction
au BufNewFile,BufRead *.inc setfiletype php
au FileType php call EnterPhp()


"C++
function! EnterCpp()
  set sw=8
  set sts=8
  set ts=8
  set noexpandtab
	map <buffer> <Leader>c :w<CR>:!clear;g++ -Wall %
	map <buffer> <Leader>r :!clear;./a.out
endfunction
au FileType cpp call EnterCpp()
au FileType cpp SyntasticDisable

"C
function! EnterC()
	map <buffer> <Leader>c :w<CR>:!clear;gcc -std=c99 -Wall %
	map <buffer> <Leader>r :!clear;./a.out
endfunction
au FileType c call EnterC()

"C#
function! EnterCS()
	map <buffer> <Leader>c :w<CR>:!clear;gmcs %
	map <buffer> <Leader>r :!clear;mono <C-R>=FileWOExt()<CR>.exe
endfunction
au FileType cs call EnterCS()

"Java
function! EnterJava()
	map <buffer> <Leader>c :w<CR>:!clear;javac %
	map <buffer> <Leader>r :!clear;java <C-R>=FileWOExt()<CR>
endfunction
au FileType java call EnterJava()

"Bash
function! EnterBash()
	map <buffer> <Leader>c :w<CR>:!clear;sh %
	map <buffer> <Leader>r :w<CR>:!clear;sh %
endfunction
au FileType sh call EnterBash()

"Perl
function! EnterPerl()
	map <buffer> <Leader>c :w<CR>:!clear;perl -wc %
	map <buffer> <Leader>r :w<CR>:!clear;perl -w %
endfunction
au FileType perl call EnterPerl()

"Ruby
function! EnterRuby()
	map <buffer> <Leader>c :w<CR>:!clear;ruby -c %
	map <buffer> <Leader>r :w<CR>:!clear;ruby %
	set tabstop=2
	set sw=2
  set sts=2
	set expandtab
endfunction
au FileType ruby call EnterRuby()

"Pascal
function! EnterPascal()
	map <buffer> <Leader>c :w<CR>:!clear;gpc %
	map <buffer> <Leader>r :!clear;./a.out
endfunction
au FileType pascal call EnterPascal()

"Scheme
function! EnterScheme()
"	map <buffer> <Leader>c :w<CR>:!clear;~/scheme/bin/mzscheme -e "`cat %`"
	map <buffer> <Leader>c :w<CR>:!clear;~/scheme/bin/mzscheme -e "`cat %`"
	abbreviate scheme_header #reader(lib "htdp-advanced-reader.ss" "lang")((modname fib) (read-case-sensitive #t) (teachpacks ()) (htdp-setting #(#t constructor repeating-decimal #t #t none #f ())))
"	map <buffer> <Leader>c :w<CR>:!clear;~/scheme/bin/mzscheme %
	map <buffer> <Leader>r :w<CR>:!clear;~/scheme/bin/mzscheme %
endfunction
au FileType scheme call EnterScheme()

"Javascript
function! EnterJavascript()
  set sts=2 sw=2 ts=2 expandtab
	map <buffer> <Leader>c :w<CR>:!clear;jslint "%"
endfunction
au FileType javascript call EnterJavascript()

"HTML
function! EnterHTML()
	map <buffer> <Leader>c :w<CR>:!open -a "Google Chrome" %
	set tabstop=2
	set sw=2
  set sts=2
	set expandtab
endfunction
au FileType html call EnterHTML()

"TEX
function! EnterTEX()
  let g:LatexBox_viewer = 'skim'
  let g:LatexBox_latexmk_options = '-pvc'
  setlocal formatoptions+=wa
  setlocal formatoptions-=c
	set spell
  abbr noi noindent
endfunction

au! FileType tex call EnterTEX()
au! FileType latex call EnterTEX()

"HAML
function! EnterHAML()
	set tabstop=2
	set sw=2
  set sts=2
	set expandtab
	retab 2
  map <buffer> <Leader>c :w<CR>:!haml % > <C-R>=FileWOExt()<CR>.html
  map <buffer> <Leader>r :w<CR>:!open -a "Google Chrome" <C-R>=FileWOExt()<CR>.html
endfunction
au FileType haml call EnterHAML()

"ActionScript
function! EnterAS()
	map <buffer> <Leader>c :!rake
	"map <buffer> <Leader>c :w<CR>:!mxmlc %
	"map <buffer> <Leader>r :w<CR>:!open -a "Google Chrome" <C-R>=FileWOExt()<CR>.swf
	set tabstop=4
	set sw=4
	set expandtab
endfunction
au FileType actionscript call EnterAS()

"Markdown
function! EnterMarkdown()
  set ts=4
  set sts=4
  set sw=4
  set expandtab
	map <buffer> <Leader>c :w<CR>:!markdown % > <C-R>=FileWOExt()<CR>.html
	map <buffer> <Leader>r :!open -a "Google Chrome" <C-R>=FileWOExt()<CR>.html
endfunction
au Filetype mkd call EnterMarkdown()
au Filetype markdown call EnterMarkdown()

"Sass
function! EnterSass()
	map <buffer> <Leader>c :w<CR>:!sass % > <C-R>=FileWOExt()<CR>.css
	map <buffer> <Leader>r :w<CR>:!sass % > <C-R>=FileWOExt()<CR>.css
endfunction
au FileType sass call EnterSass()

"Coffee
function! EnterCoffee()
  set sts=4
  set sw=4
  set ts=4
endfunction
au FileType coffee call EnterCoffee()

"Dot
function! EnterDot()
  map <buffer> <Leader>c :w<CR>:!dot -Tpng < % > <C-R>=FileWOExt()<CR>.png
endfunction
au FileType dot call EnterDot()

"Haskell
function! EnterHaskell()
  set ts=4
  set sw=4
  set sts=4
  map <buffer> <Leader>r :!./<C-R>=FileWOExt()<CR>
  map <buffer> <Leader>c :w<CR>:!ghc -O3 -o <C-R>=FileWOExt()<CR> %
endfunction
au FileType haskell call EnterHaskell()

