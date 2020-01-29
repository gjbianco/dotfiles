set -x EDITOR vim
set -x PATH $PATH:$HOME/bin

# fundle plugins ----------

# work with bash source scripts
fundle plugin 'edc/bass'

# add !! syntax
fundle plugin 'oh-my-fish/plugin-bang-bang'

# end fundle plugins ------
fundle init # --profile # show plugin load time

# auto run nvm use and make it "quiet"
# nvm use default >> /dev/null