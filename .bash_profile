set_prompt_style () {

  PS1="┌─[\[\e[34m\]\h\[\e[0m\]][\[\e[32m\]\w\[\e[0m\]]\n└─╼ "
}
set_prompt_style

# enable terminal colors
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

export EDITOR=vim
export PATH=~/bin:$PATH

alias ytdl="youtube-dl -f best --no-check-certificate"
alias cow="fortune | cowsay"
alias v=vim
alias tmux="TERM=screen-256color-bce tmux"

if [ -e /usr/share/terminfo/x/xterm-256color ]; then
        export TERM='xterm-256color'
else
        export TERM='xterm-color'
fi
