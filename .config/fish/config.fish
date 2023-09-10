set -x EDITOR vim
fish_add_path $HOME/bin
fish_add_path /opt/homebrew/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin

alias sk="java -jar $HOME/code/gls/scaffolding/tools/sk/target/scaffolding.jar"
alias vale="$HOME/bin/vale/bin/vale"
alias wb="sk flamel && rm -rf guides/tmp && flamel sg"
alias ws="scp 'guides/tmp/en-US/pdf/*.pdf' guys-macbook-air:Desktop"
alias wp="open 'guides/tmp/en-US/pdf/*.pdf' &"

. ~/.config/fish/functions/fishmarks.fish
