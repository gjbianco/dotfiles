set -x EDITOR vim
set -x RESTIC_REPOSITORY "sftp:rsync:data-backup"
fish_add_path $HOME/bin
fish_add_path /opt/homebrew/bin
fish_add_path $HOME/go/bin
fish_add_path $HOME/.local/bin

alias vale="$HOME/bin/vale/bin/vale"
alias wb="sk flamel && rm -rf guides/tmp && flamel sg"
alias ws="scp 'guides/tmp/en-US/pdf/*.pdf' guys-macbook-air:Desktop"
alias wp="zathura 'guides/tmp/en-US/pdf/*.pdf' &"

. ~/.config/fish/functions/fishmarks.fish
