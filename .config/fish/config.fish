set -x EDITOR vim
set -x PATH $PATH:$HOME/bin

alias use="nvm use default"
alias pm="podman-machine"
alias vim="nvim"
alias typetest="gotta-go-fast -pr ~/bin/christmas_carol.txt --min-paragraph-len 200"
alias recent="ls -lhtr | tail"
alias adoc="asciidoctor-pdf"

# fundle plugins ----------

# work with bash source scripts
fundle plugin 'edc/bass'

# add !! syntax
fundle plugin 'oh-my-fish/plugin-bang-bang'

# end fundle plugins ------
fundle init # --profile # show plugin load time

# auto run nvm use and make it "quiet"
# nvm use default >> /dev/null
