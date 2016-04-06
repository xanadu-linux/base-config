# System-wide .bashrc file for interactive bash(1) shells.

# To enable the settings / commands in this file for login shells as well,
# this file has to be sourced in /etc/profile.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, overwrite the one in /etc/profile)
PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '

# Commented out, don't overwrite xterm -T "title" -n "icontitle" by default.
# If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
#    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
#    ;;
#*)
#    ;;
#esac

# enable bash completion in interactive shells
#if ! shopt -oq posix; then
#  if [ -f /usr/share/bash-completion/bash_completion ]; then
#    . /usr/share/bash-completion/bash_completion
#  elif [ -f /etc/bash_completion ]; then
#    . /etc/bash_completion
#  fi
#fi

# if the command-not-found package is installed, use it
if [ -x /usr/lib/command-not-found -o -x /usr/share/command-not-found/command-not-found ]; then
	function command_not_found_handle {
	        # check because c-n-f could've been removed in the meantime
                if [ -x /usr/lib/command-not-found ]; then
		   /usr/lib/command-not-found -- "$1"
                   return $?
                elif [ -x /usr/share/command-not-found/command-not-found ]; then
		   /usr/share/command-not-found/command-not-found -- "$1"
                   return $?
		else
		   printf "%s: command not found\n" "$1" >&2
		   return 127
		fi
	}
fi

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s checkwinsize
export HISTIGNORE="ls:clear"
export EDITOR="nano"
alias ls='ls --color'
alias rotorar='unrar e -kb -y'
if [[ -f /run/tor.lock ]]; then
	export LD_PRELOAD="/lib/libtorsocks.so"
	export http_proxy="http://127.0.0.1:8118"
	export HTTP_PROXY="http://127.0.0.1:8118"
	export https_proxy="http://127.0.0.1:8118"
	export HTTPS_PROXY="http://127.0.0.1:8118"
	export ftp_proxy="http://127.0.0.1:8118"
	export FTP_PROXY="http://127.0.0.1:8118"
	export rsync_proxy="http://127.0.0.1:8118"
	export RSYNC_PROXY="http://127.0.0.1:8118"
	export all_proxy="socks://127.0.0.1:8123"
	export ALL_PROXY="socks://127.0.0.1:8123"
	export no_proxy="localhost,127.0.0.1"
	export NO_PROXY="localhost,127.0.0.1"
else
	unset LD_PRELOAD
	unset http_proxy
	unset HTTP_PROXY
	unset https_proxy
	unset HTTPS_PROXY
	unset ftp_proxy
	unset FTP_PROXY
	unset rsync_proxy
	unset RSYNC_PROXY
	unset all_proxy
	unset ALL_PROXY
	unset no_proxy
	unset NO_PROXY
fi
