" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" keep 50 lines of command line history
set history=500

" show the cursor position all the time
set ruler

" display incomplete commands
set showcmd

set incsearch
set hlsearch
set ignorecase

" Don't use Ex mode, use Q for formatting
map Q gq


syntax on
set background=dark

set ts=4 sts=4 sw=4 expandtab
set smarttab
set nowrap

set modelines=5
set listchars=tab:»·,trail:·
set list

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
  au FileType css setlocal ts=2 sw=2 sts=2 expandtab
  au FileType css setlocal ts=2 sw=2 sts=2 expandtab
  au FileType xhtml setlocal ts=2 sw=2 sts=2 expandtab
  au FileType htmldjango setlocal ts=2 sw=2 sts=2 expandtab
  au FileType javascript setlocal ts=2 sw=2 sts=2 expandtab

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
  au BufRead,BufNewFile *.zsh-theme setlocal filetype=zsh
  au BufRead,BufNewFile *.zsh-overrides setlocal filetype=zsh
  au BufRead,BufNewFile *.zsh       setlocal filetype=zsh

  " ruby files
  au BufRead,BufNewFile *.cap       setlocal filetype=ruby

  " structured text formats
  set updatetime=1000
  au BufRead,BufNewFile *.md        setlocal filetype=text tw=76
  au BufRead,BufNewFile *.rst       setlocal filetype=text tw=76
  "au BufRead,BufNewFile *.md        let b:start_time = localtime()
  au CursorHold         *.md        update
  "au CursorHold         *.md        call UpdateFile()
  "au BufWritePre        *.md        let b:start_time = localtime()

  " .sccs == sassy CSS
  au BufRead,BufNewFile *.css       setlocal filetype=css tw=0


  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

  " vim -b : edit binary using xxd-format!
  augroup Binary
    au!
    au BufReadPre  *.pgm let &bin=1
    au BufReadPost *.pgm if &bin | %!xxd
    au BufReadPost *.pgm set ft=xxd | endif
    au BufWritePre *.pgm if &bin | %!xxd -r
    au BufWritePre *.pgm endif
    au BufWritePost *.pgm if &bin | %!xxd
    au BufWritePost *.pgm set nomod | endif
  augroup END

else

  set autoindent

endif " has("autocmd")

if has("gui_running")
    set gfn:Menlo:h14.00
    set go-=r
    " set go-=T
    set go-=L
    set lines=65
    set columns=239
    color solarized
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

fun! UpdateFile()
  " save file after 3 seconds of inactivity
  if ((localtime() - b:start_time) >= 3)
    update
    let b:start_time = localtime()
  else
    echo "Only " . (localtime() - b:start_time) . " seconds have elapsed"
  endif
endfun

