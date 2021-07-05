set -x EDITOR vim
set -x PATH $PATH $HOME/bin
set -x PATH $PATH $HOME/go/bin
set -x PATH /usr/local/opt/gnu-sed/libexec/gnubin $PATH
set -x PATH /usr/local/opt/findutils/libexec/gnubin $PATH
set -x CONTAINER_HOST ssh://vagrant@127.0.0.1:2222/run/podman/podman.sock
set -x CONTAINER_SSHKEY ~/bin/podman-vagrant/.vagrant/machines/default/virtualbox/private_key

alias use="nvm use default"
alias pm="podman-machine"
alias vim="nvim"
alias typetest="gotta-go-fast -pr ~/bin/christmas_carol.txt --min-paragraph-len 200"
alias recent="ls -lhtr | tail"
alias adoc="asciidoctor-pdf"
alias t="mosh fedora"

# fundle plugins ----------

# work with bash source scripts
fundle plugin 'edc/bass'

# add !! syntax
fundle plugin 'oh-my-fish/plugin-bang-bang'

# fishmarks (like bashmarks)
fundle plugin 'techwizrd/fishmarks'

# end fundle plugins ------
fundle init # --profile # show plugin load time

. ~/.config/fish/fundle/techwizrd/fishmarks/marks.fish

# auto run nvm use and make it "quiet"
# nvm use default >> /dev/null
