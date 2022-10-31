set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

source ~/.vimrc

let g:loaded_perl_provider = 0

"The ftplugin, and other default dirs are required automagically
lua require('config')
