set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath


let g:loaded_perl_provider = 0

"Load packages (with neovim 0.12) 
" Will migrate to init.lua from this init.vim at a later stage.
lua require("packages")

"The ftplugin, and other default dirs are required automagically
lua require("config")

source ~/.vimrc
