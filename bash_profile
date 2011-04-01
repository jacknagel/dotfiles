#
# ~/.bash_profile
#

# Source .bashrc
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# Source bash_prompt
if [ -f ~/.bash_prompt ]; then
    . ~/.bash_prompt
fi

# Source .bash_aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Source rvm (Ruby Version Manager)
if [ -f ~/.rvm/scripts/rvm ]; then
    . ~/.rvm/scripts/rvm
fi
