set -x EDITOR vim
fish_add_path $HOME/bin
fish_add_path /opt/homebrew/bin
# fish_add_path $HOME/go/bin
# source ~/.asdf/asdf.fish

alias vim="nvim"
alias sk="java -jar $HOME/code/gls/scaffolding/tools/sk/target/scaffolding.jar"
alias valesk="vale content/**/*.adoc"
alias valediff='vale (git diff --name-only main | grep -e ".*\.adoc\$")'

# fundle plugins ----------
fundle plugin 'edc/bass'
fundle plugin 'oh-my-fish/plugin-bang-bang'
fundle plugin 'techwizrd/fishmarks'
# end fundle plugins ------
fundle init # --profile # show plugin load time

. ~/.config/fish/fundle/techwizrd/fishmarks/marks.fish
. $HOME/.fishmarks/marks.fish
