set -x EDITOR vim
set -x PATH $PATH:$HOME/bin

alias use="nvm use default"

# fundle plugins ----------

# work with bash source scripts
fundle plugin 'edc/bass'

# add !! syntax
fundle plugin 'oh-my-fish/plugin-bang-bang'

fundle plugin 'jorgebucaran/fish-spark'

# end fundle plugins ------
fundle init # --profile # show plugin load time

# auto run nvm use and make it "quiet"
# nvm use default >> /dev/null
