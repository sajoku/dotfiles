#!/usr/bin/env sh

echo "Bundling up homebrew installed apps"
brew bundle --file=~/.dotfiles/homebrew/.Brewfile


echo "Setup symlinks in home"
ln -s  ~/dotfiles/ackrc ~/.ackrc
ln -s  ~/dotfiles/agignore ~/.agignore
ln -s  ~/dotfiles/gitgignore_global ~/.gitignore_global
ln -s  ~/dotfiles/.irbc ~/irbrc
ln -s  ~/dotfiles/pdbrc ~/.pdbrc
ln -s  ~/dotfiles/pryrc ~/.pryrc
ln -s  ~/dotfiles/tmux.conf ~/.tmux.conf
ln -s  ~/dotfiles/vimrc ~/.vimrc
ln -s  ~/dotfiles/homebrew/Brewfile ~/.Brewfile


echo "Setup symlinks in home .config"
ln -s  ~/dotfiles/bat/ ~/.config/bat
ln -s  ~/dotfiles/fish/ ~/.config/fish
ln -s  ~/dotfiles/starship.toml ~/.config/starship.toml
ln -s  ~/dotfiles/config/wezterm/ ~/.config/wezterm


echo "Setup symlinks for neovim"

ln -s ~/dotfiles/coc-settings.json ~/.config/nvim/coc-settings.json
ln -s ~/dotfiles/ftplugin/ ~/.config/nvim/ftplugin
ln -s ~/dotfiles/init.vim ~/.config/nvim/init.vim
ln -s ~/dotfiles/vim/lua/ ~/.config/nvim/lua/
ln -s ~/dotfiles/vim/config.lua ~/.config/nvim/lua/config.lua

