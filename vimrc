scriptencoding utf-8
set encoding=utf-8

set nocompatible
set backspace=indent,eol,start
set history=500

set ruler
set showcmd
set incsearch
set hlsearch
set ignorecase
set hidden
set scrolloff=5

syntax on
set background=light

set ts=4 sts=4 sw=4 expandtab
set smarttab
set nowrap

set modelines=5
set list listchars=tab:»·,trail:·

set splitbelow

set updatetime=1000

" Helpful bindings
let mapleader = " "

" toggle case of current word
:nnoremap <c-u> mbviw~`b
:inoremap <c-u> <esc><c-u>li

" manipulate ~/.vimrc easily
:nnoremap <leader>ev :vsplit $MYVIMRC<cr>
:nnoremap <leader>sv :source $MYVIMRC<cr>

:nnoremap ## :execute "rightbelow vsplit ".bufname("#")<cr>

set wildmenu
set wildmode=longest:full,full
set wildignore+=*.db,*.o,*.obj,*.swp,*.bak,*.git,*.pyc,**/_trial_temp/**,*.egg-info/**,*.egg/**,**/build/**,**/htmlcov/**,**/dist/**,**/_build/**,**/.tox/**,*.class,**/.cache/**


" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype on
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " thanks, @xcolour: https://github.com/xcolour/dotfiles/blob/master/vimrc
  au FileType text setlocal textwidth=72

  au FileType html setlocal ts=2 sw=2 sts=2 expandtab
  au FileType xhtml setlocal ts=2 sw=2 sts=2 expandtab
  au FileType htmldjango setlocal ts=2 sw=2 sts=2 expandtab
  au FileType javascript setlocal ts=2 sw=2 sts=2 expandtab
  au FileType css setlocal tw=0 ts=2 sw=2 sts=2 expandtab
  au FileType sass setlocal tw=0 ts=2 sw=2 sts=2 expandtab
  au FileType go setlocal ts=4 sts=4 sw=4 noexpandtab listchars=tab:\ \ ,trail:·
  au FileType typescript setlocal tw=0 ts=2 sw=2 sts=2 expandtab

  au FileType ruby setlocal tw=0 ts=2 sw=2 sts=2 expandtab

  " python
  au BufRead,BufNewFile *.wsgi      setlocal filetype=python

  " text files
  au BufRead,BufNewFile *.txt       setlocal filetype=text

  " php files
  au BufRead,BufNewFile *.module    setlocal filetype=php
  au BufRead,BufNewFile *.inc       setlocal filetype=php
  au BufRead,BufNewFile *.install   setlocal filetype=php

  " html templates
  au BufRead,BufNewFile *.mako      setlocal filetype=html
  au BufRead,BufNewFile *.ftl       setlocal filetype=html

  " zsh configs and scripts
  au BufRead,BufNewFile *.zsh*      setlocal filetype=zsh
  au BufRead,BufNewFile *.zsh       setlocal filetype=zsh

  " ruby files
  au BufRead,BufNewFile *.cap       setlocal filetype=ruby

  " structured text formats
  au BufRead,BufNewFile *.md        setlocal filetype=text tw=76
  au BufRead,BufNewFile *.rst       setlocal filetype=text tw=76

  au BufRead,BufNewFile *.scss      setlocal filetype=sass
  au BufRead,BufNewFile *.sass      setlocal filetype=sass

  au BufRead,BufNewFile *.json      setlocal filetype=javascript ts=2 sts=2 sw=2

  " Makefiles
  au BufRead,BufNewFile Makefile*   setlocal nolist noexpandtab

  " Go source
  au BufRead,BufNewFile *.go        setlocal filetype=go


  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

else

  set autoindent

endif " has("autocmd")

call pathogen#infect()

" reload ctrl-p cache
:nnoremap ^] CtrlPClearCache

" ignore some stuff in ctrl-p
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|\.git$\|\.hg$\|\.svn\|coverage\|htmlcov$'

if has("gui_running")
  set guioptions+=T
  set gfn:Menlo:h14.00
  set go-=r
  " set go-=T
  set go-=L
  set lines=71
  set columns=239
  color solarized

  runtime ftplugin/man.vim
  :nmap <expr>K ":Man ".expand("<cword>")."<CR>"
else
  color desert
endif


fun! PyCrumbs()
  let on = line(".")
  let output = "line ".string(on)
  ?^.\+$
  let lastindent = match(getline("."), "[^ \t]")
  while (1)
    ?def\|class\|if
    if (line(".") > on)
      let output = "module, ".output
      break
    endif

    let curline = getline(".")

    let indent = match(curline, "[^ \t]")
    if (indent >= lastindent)
      echo "indent >= lastindent" indent lastindent
      continue
    endif
    let lastindent = indent

    if (match(curline, "^ *if") >= 0)
      continue
    endif
    if (match(curline, "def") >= 0)
      let part = matchstr(curline, "def[^(]*")
    else
      let part = matchstr(curline, "class[^(]*")
    endif
    let output = part."  >  ".output

    " stop when we reach a def/class at the start of the line
    if (strpart(curline, 0, 1) != " " && strpart(curline, 0, 1) != "\t")
      break
    endif
  endwhile
  echo output
endfun

nmap <expr> gf PyCrumbs()
nmap tt :NERDTreeToggle<CR>

if filereadable(glob("~/.vimrc.local"))
  source ~/.vimrc.local
endif
