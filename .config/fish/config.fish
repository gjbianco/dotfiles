set -x EDITOR vim
set -x PATH $PATH:$HOME/bin

# fundle plugins
fundle plugin 'edc/bass'
fundle plugin 'oh-my-fish/plugin-bang-bang'

fundle init
# end fundle plugins

# auto run nvm use and making it "quiet"
nvm use default >> /dev/null
