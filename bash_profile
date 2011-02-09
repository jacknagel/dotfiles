### ~/.bash_profile

## Source global .bashrc
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

## Source any local additions
if [ -f ~/.bash_local ]; then
  . ~/.bash_local
fi

## Source rvm
if [ -f ~/.rvm/scripts/rvm ]; then
  . ~/.rvm/scripts/rvm
fi