set -x EDITOR vim
set -x PATH $PATH:$HOME/bin

fundle plugin 'edc/bass'

fundle init

nvm use default >> /dev/null
