set_prompt_style () {

  PS1="┌─[\[\e[34m\]\h\[\e[0m\]][\[\e[32m\]\w\[\e[0m\]]\n└─╼ "
}
set_prompt_style

# enable terminal colors
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

export EDITOR=vim
export PATH=~/bin:$PATH

export ANSIBLE_NOCOWS=1
export ANSIBLE_RETRY_FILES_ENABLED=false

alias ytdl="youtube-dl -f best --no-check-certificate"
# alias cow="fortune | cowsay"
# alias v=vim
alias tmux="TERM=screen-256color-bce tmux"
alias rscp='rsync --archive --xattrs --acls --progress --rsh="ssh"'

# source ~/bin/oc_completion.sh

# function setjdk() {
#   if [ $# -ne 0 ]; then
#    removeFromPath '/System/Library/Frameworks/JavaVM.framework/Home/bin'
#    if [ -n "${JAVA_HOME+x}" ]; then
#     removeFromPath $JAVA_HOME
#    fi
#    export JAVA_HOME=`/usr/libexec/java_home -v $@`
#    export PATH=$JAVA_HOME/bin:$PATH
#   fi
#  }
#  function removeFromPath() {
#   export PATH=$(echo $PATH | sed -E -e "s;:$1;;" -e "s;$1:?;;")
#  }
# setjdk 1.8

if [ -e /usr/share/terminfo/x/xterm-256color ]; then
        export TERM='xterm-256color'
else
        export TERM='xterm-color'
fi

# export WORKON_HOME=~/.virtualenvs
# source /usr/local/bin/virtualenvwrapper.sh

# export NVM_DIR="/Users/guybiancoiv/.nvm"
#  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
#  . "$(brew --prefix nvm)/nvm.sh"

