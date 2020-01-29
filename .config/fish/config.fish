set -x EDITOR vim
set -x PATH $PATH:$HOME/bin

# fundle plugins ----------

# work with bash source scripts
fundle plugin 'edc/bass'

# end fundle plugins ------
fundle init # --profile # show plugin load time

# auto run nvm use and make it "quiet"
# nvm use default >> /dev/null
