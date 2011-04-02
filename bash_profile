#
# ~/.bash_profile
#

# Source .bashrc
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# Source rvm (Ruby Version Manager)
# rvm hooks into cd(), so source this before aliases
if [ -f ~/.rvm/scripts/rvm ]; then
    . ~/.rvm/scripts/rvm
fi

# Source .bash_aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
