PROMPT_COMMAND="prompt"
NoColor="\033[0m"
Cyan="\033[0;36m"
Green="\033[0;32m"
Red="\033[0;31m"
BRed="\033[0;41m"
Yellow="\033[0;33m"
Magenta="\033[0;46m"

Gras="\033[0;01m"

# Chars
RootPrompt="\#"
NonRootPrompt="\$"

# Contextual prompt
prompt() {
    local EXIT="$?"
    USERNAME=`whoami`
    HOSTNAME=`hostname -s`
    
    # Change the Window title
    WINDOWTITLE="$USERNAME@$HOSTNAME"
    echo -ne "\033]0;$WINDOWTITLE\007"
    
    # Change the dynamic prompt
    LEFTPROMPT="\[$Cyan\]$USERNAME@$HOSTNAME"

    # If python virtualenv activate display it
    if [ ! -z $VIRTUAL_ENV ] ; then
        LEFTPROMPT="\[$Red\]("`basename $VIRTUAL_ENV`") "$LEFTPROMPT
    fi
    
    GITSTATUS=$(git status 2> /dev/null)
    if [ $? -eq 0 ]; then
        echo $GITSTATUS | grep "\(not staged\|modifié\)" > /dev/null 2>&1
        if [ $? -eq 0 ]; then
            LEFTPROMPT=$LEFTPROMPT"\[$Red\]"
        else
            LEFTPROMPT=$LEFTPROMPT"\[$Green\]"
        fi
        BRANCH=`git rev-parse --abbrev-ref HEAD`
        LEFTPROMPT=$LEFTPROMPT" ["$BRANCH"]"
    fi
    nowcwd=`pwd`
    devdir="/home/$USERNAME/dev/"
    if [[ $nowcwd == $devdir* ]]; then
        #LEFTPROMPT="\[$Yellow\]@dev=> "${$nowcwd/$devdir/""/}"\n"$LEFTPROMPT
        LEFTPROMPT="\[$Yellow\]\w\n"$LEFTPROMPT
    else
        LEFTPROMPT="\[$Green\]\w\n"$LEFTPROMPT
    fi
    if [[ "0" != "${EXIT}" ]]; then
      LEFTPROMPT=$LEFTPROMPT"\[$Red\][${EXIT}]"
    else
      LEFTPROMPT=$LEFTPROMPT"\[$Green\][${EXIT}]"
    fi

    if [ $EUID -ne 0 ]; then
        PS1=$LEFTPROMPT$NonRootPrompt"\[$NoColor\] "
    else
        PS1=$LEFTPROMPT"\[$BRed\]"$RootPrompt"\[$NoColor\] "
    fi
}

# Define PROMPT_COMMAND if not already defined (fix: Modifying title on SSH connections)
if [ -z "$PROMPT_COMMAND" ]; then
    case $TERM in
        xterm*)
            PROMPT_COMMAND='printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
        ;;
        screen)
            PROMPT_COMMAND='printf "\033]0;%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'
        ;;
    esac
fi
                                     
# Main prompt

if [ $EUID -ne 0 ]; then
    PS1=$NonRootPrompt" "
else
    PS1=$RootPrompt" "
fi
############################################################################

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return


# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
      debian_chroot=$(cat /etc/debian_chroot)
      fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
    esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
    *)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
      test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
      alias ls='ls --color=auto'
      #alias dir='dir --color=auto'
      #alias vdir='vdir --color=auto'

      #alias grep='grep --color=auto'
      #alias fgrep='fgrep --color=auto'
      #alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
      . ~/.bash_aliases
      fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
      . /etc/bash_completion
      fi

export EDITOR=/usr/bin/vim

export PATH=$PATH:~/bin

# history navigation with arrows
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

set -o vi
# pip bash completion start
_pip_completion()
{
      COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
                         COMP_CWORD=$COMP_CWORD \
                                            PIP_AUTO_COMPLETE=1 $1 ) )
}
complete -o default -F _pip_completion pip
# pip bash completion end
function git() {
    case $* in
        init* ) shift 1; command git init --template=/home/herve/dev/.git-template "$@" ;;
        clone* ) shift 1; command git clone --template=/home/herve/dev/.git-template "$@" ;;
        * ) command git "$@" ;;
    esac
}
# added by travis gem
[ -f /home/herve/.travis/travis.sh ] && source /home/herve/.travis/travis.sh

function connect() {
    git init .
    git remote add origin https://github.com/4383/$(basename $(pwd))
    touch .gitignore
    touch .gitkeep
    git add .
    git commit -m "initialize project"

}

export PATH="$HOME/.cargo/bin:$PATH"
# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend
