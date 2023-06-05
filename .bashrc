# ~/.bashrc

# Terminal color
use_color=ture
force_color_prompt=yes

# Editor
export VISUAL=hx
export EDITOR="$VISUAL"
export TERM=xterm-256color

# Terminal prompt
LIGHT_BLUE="\e[1;34m"
LIGHT_GRAY="\e[0;37m"
END="\e[m"
PS1="${LIGHT_GRAY}---${END} ${LIGHT_BLUE}\A${END} ${LIGHT_GRAY}\w${END}\n${LIGHT_GRAY}-----${END} "

# Aliases
alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -a'
alias lla='ls -la'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias less='less --use-color'

alias bashrc='source ~/.bashrc'
alias lstime='date "+%I:%M%P"'
