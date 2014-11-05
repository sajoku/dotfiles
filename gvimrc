if has("gui_running")
" set relativenumber
  set guifont=Source\ Code\ Pro\ Light:h18
  colorscheme solarized
  set t_Co=256
  set background=light
  set fuoptions=maxvert,maxhorz
  :map <D-enter> :set fullscreen! <CR>

  " remove scrollbars
  set guioptions-=r
  set guioptions-=L
  set hlsearch

  "tab switching in normal mode
  map <D-1> :tabn 1<CR>
  map <D-2> :tabn 2<CR>
  map <D-3> :tabn 3<CR>
  map <D-4> :tabn 4<CR>
  map <D-5> :tabn 5<CR>
  map <D-6> :tabn 6<CR>
  map <D-7> :tabn 7<CR>
  map <D-8> :tabn 8<CR>
  map <D-9> :tabn 9<CR>

  "tab switching in insert mode
  map! <D-1> <C-O>:tabn 1<CR>
  map! <D-2> <C-O>:tabn 2<CR>
  map! <D-3> <C-O>:tabn 3<CR>
  map! <D-4> <C-O>:tabn 4<CR>
  map! <D-5> <C-O>:tabn 5<CR>
  map! <D-6> <C-O>:tabn 6<CR>
  map! <D-7> <C-O>:tabn 7<CR>
  map! <D-8> <C-O>:tabn 8<CR>
  map! <D-9> <C-O>:tabn 9<CR>

  macmenu &File.New\ Tab key=<nop>
  map <D-t> :tabnew<CR>

  hi LineProximity ctermfg=white ctermbg=gray guifg=white guibg=#757160 
  hi LineOverflow  ctermfg=white ctermbg=red guifg=white guibg=#FF2270
  autocmd BufRead,BufNewFile,VimEnter *.rb let w:m1=matchadd('LineProximity', '\%<120v.\%>115v', -1)
  autocmd BufRead,BufNewFile,VimEnter *.rb let w:m2=matchadd('LineOverflow', '\%>119v.\+', -1)
  " autocmd VimEnter *.rb autocmd WinEnter * let w:created=1
  " autocmd VimEnter *.rb let w:created=1



endif
