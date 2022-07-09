set -x EDITOR vim
set -x BUN_INSTALL $HOME/.bun
fish_add_path $HOME/bin
fish_add_path /opt/homebrew/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.local/bin
fish_add_path $BUN_INSTALL/bin
#fish_add_path $HOME/.deno/bin

alias use="nvm use default"
alias pm="podman-machine"
alias vim="nvim"
alias typetest="gotta-go-fast -pr ~/bin/christmas_carol.txt --min-paragraph-len 200"
alias valesg='vale guides/en-US/sg-chapters/topics/**/*.adoc'
alias valediff='vale (git diff --name-only main | grep -e ".*\.adoc\$")'
alias valefiles='vale --output=line guides/en-US/sg-chapters/topics/**/*.adoc|cut -d: -f1|uniq'

# fundle plugins ----------
fundle plugin 'edc/bass'
fundle plugin 'oh-my-fish/plugin-bang-bang'
fundle plugin 'techwizrd/fishmarks'
# fundle plugin 'evanlucas/fish-kubectl-completions'
# end fundle plugins ------
fundle init # --profile # show plugin load time

. ~/.config/fish/fundle/techwizrd/fishmarks/marks.fish
. $HOME/.fishmarks/marks.fish

# auto run nvm use and make it "quiet"
# nvm use default >> /dev/null
