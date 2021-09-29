set -x EDITOR vim
fish_add_path $HOME/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.deno/bin

alias use="nvm use default"
alias pm="podman-machine"
alias vim="nvim"
alias typetest="gotta-go-fast -pr ~/bin/christmas_carol.txt --min-paragraph-len 200"
alias recent="ls -lhtr | tail"
alias adoc="asciidoctor-pdf"
alias le="exa -F"
alias lel="le --long --header --git"
alias tree="le --tree"
alias treel='tree --long --header --git'

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
