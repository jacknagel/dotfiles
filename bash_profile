#
# ~/.bash_profile
#

# Source global .bashrc
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# Source global .bash_aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Source any local additions
if [ -f ~/.bash_local ]; then
    . ~/.bash_local
fi

# Source rvm (Ruby Version Manager)
if [ -f ~/.rvm/scripts/rvm ]; then
    . ~/.rvm/scripts/rvm
fi
