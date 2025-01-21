set -x EDITOR vim
set -x RESTIC_REPOSITORY "sftp:rsync:data-backup"
fish_add_path $HOME/bin
fish_add_path /opt/homebrew/bin
fish_add_path $HOME/go/bin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/REAPER/REAPER

alias vale="$HOME/bin/vale/bin/vale"
alias wb="sk flamel && rm -rf guides/tmp && flamel sg"
alias wsm="scp 'guides/tmp/en-US/pdf/*.pdf' macbook:Desktop"
alias wp="zathura 'guides/tmp/en-US/pdf/*.pdf' &"
alias yt="yt-dlp --sponsorblock-remove intro,preview,interaction,sponsor --sponsorblock-mark all"
alias bgm="mpv . --shuffle --loop --no-resume-playback"
alias m="aerc"
alias got="grc go test -v"
alias n="newsboat"

function f
  find . -iname "*$argv*"
end

. ~/.config/fish/functions/fishmarks.fish
