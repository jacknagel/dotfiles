dotfiles
========
The configuration files and other stuff that goes in my home directory

I keep the working tree for my home directory in ~/.dotfiles and symlink stuff into ~/. Most of these files contain things that I gleaned from other people's dotfile repos, so thanks to everyone whose dotfiles provided me with something useful. I have tried to give credit for things that are nontrivial (e.g., showing Git information in the Bash prompt).

Contents
--------
    Makefile                installs dotfiles to ~/
    bash_aliases            bash aliases; symlinked to ~/.bash_aliases
    bash_profile            bash profile; symlinked to ~/.bash_profile
    bash_prompt             bash prompt factored out of bashrc; symlinked to ~/.bash_prompt
    bashrc                  bash configuration; symlinked to ~/.bashrc
    bin/                    collection of lightweight utilities; symlinked to ~/bin
    gitconfig               global git configuration; symlinked to ~/.gitconfig
    gitignore               global git excludesfile; symlinked to ~/.gitignore
    gpg/                    copies of my GPG public key
    inputrc                 readline configuration; symlinked to ~/.inputrc
    smartmontools/          configuration for the smartmontools package
    vim/                    vim directory; symlinked to ~/.vim
    vimrc                   vim configuration; symlinked to ~/.vimrc

Credit
------

