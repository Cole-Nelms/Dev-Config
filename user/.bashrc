# ~/.bashrc

use_color=ture
force_color_prompt=yes

export VISUAL=nvim
export EDITOR="$VISUAL"
export FZF_DEFAULT_COMMAND="find -L"
export TERM=xterm-256color

LIGHT_BLUE="\e[1;34m"
LIGHT_GRAY="\e[0;37m"
END="\e[m"

PS1="${LIGHT_GRAY}---${END} ${LIGHT_BLUE}\u${END} ${LIGHT_GRAY}\w${END}\n${LIGHT_GRAY}-----${END} "

alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias less='less --use-color'

alias rs='rsync -aAXH'
alias bashrc='source ~/.bashrc'
alias lstime='date "+%I:%M%P"'
alias npm_server='npm run start 1> /dev/null 2>> /tmp/npm_debug_server &'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
