#reload profile
alias reload='. ~/.bash_profile && echo "reloaded"'

########################################
#         COLOR DEFINITIONS            #
########################################

CS='\['
CE='\]'

export NC='\033[0m'

export BLACK='\033[0;30m'
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;33m'
export BLUE='\033[0;34m'
export PURPLE='\033[0;35m'
export CYAN='\033[0;36m'
export WHITE='\033[0;37m'

#bold
export BBLACK='\033[0;90m'
export BRED='\033[0;91m'
export BGREEN='\033[0;92m'
export BYELLOW='\033[0;93m'
export BBLUE='\033[0;94m'
export BPURPLE='\033[0;95m'
export BCYAN='\033[0;96m'
export BWHITE='\033[0;97m'

#background
export ON_BLACK='\033[0;40m'
export ON_RED='\033[0;41m'
export ON_GREEN='\033[0;42m'
export ON_YELLOW='\033[0;43m'
export ON_BLUE='\033[0;44m'
export ON_PURPLE='\033[0;45m'
export ON_CYAN='\033[0;46m'
export ON_WHITE='\033[0;47m'

#bold background
export ON_BBLACK='\033[0;100m'
export ON_BRED='\033[0;101m'
export ON_BGREEN='\033[0;102m'
export ON_BYELLOW='\033[0;103m'
export ON_BBLUE='\033[0;104m'
export ON_BPURPLE='\033[0;105m'
export ON_BCYAN='\033[0;106m'
export ON_BWHITE='\033[0;107m'

#add git branch to prompt when available and colorize
if [[ -s ~/.git-prompt.sh ]]; then
	. ~/.git-prompt.sh
	export GIT_PS1_SHOWDIRTYSTATE='true'
	export GIT_PS1_SHOWSTASHSTATE='true'
	export GIT_PS1_SHOWUNTRACKEDFILES='true'
	export GIT_PS1_SHOWUPSTREAM='auto'
	export GIT_PS1_STATESEPARATOR=' '
	export PS1="$CS$BPURPLE$CE\!$CS$NC$CE $CS$BWHITE$CE\u$CS$NC$CE:$CS$BCYAN$CE\W$CS$NC$CE $CS$BYELLOW$CE\$(__git_ps1 '%s ')$CS$NC$CE\$ "
else
	export PS1="$CS$BPURPLE$CE\!$CS$NC$CE $CS$BWHITE$CE\u$CS$NC$CE:$CS$BCYAN$CE\W$CS$NC$CE $CS$BYELLOW$CE\$(git branch 2>/dev/null | grep '^*' | colrm 1 2)$CS$NC$CE\$ "
fi

#add git autocompletion, if it exists
[[ -s ~/.git-completion.bash ]] && . ~/.git-completion.bash

#some useful git aliases
git config --global --replace-all alias.cd checkout
git config --global --replace-all alias.stat status
git config --global --replace-all alias.ls branch
git config --global --replace-all merge.tool vimdiff
git config --global --replace-all merge.conflictstyle diff3
git config --global --replace-all color.ui true

#set default editor to vim
export EDITOR=vim

#use my color scheme for ls
export LSCOLORS="gxfxcxdxbxegedabagacad"

#use nullglob (if glob doesn't expand into anything, it is not preserved as literal text)
shopt -s nullglob

#aliases
alias quit='exit'                           # Because Mac OS X tends to call it quit
alias ls='ls -GF'                           # Preferred 'ls' implementation
alias lsa='ls -aGF'                         # Preferred 'ls -a' alias
alias cp='cp -iv'                           # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias rm='rm -i'                            # Preferred 'rm' implementation
alias hidden='ls -a | grep "^\."'           # List all hidden files
alias cd..='cd ../'                         # Go back one directory level
alias ..='cd ../'                           # Shorter version of cd..
alias ~='cd ~'                              # Shortcut to cd ~
alias edit='vim'                            # Open a file in vim
alias readonly='vim -R'                     # Open a file in readonly mode in vim
alias explore='vim +Explore'                # Open vim's Explore mode in current directory
alias finder='open -a Finder ./'            # Open current directory in Finder
alias gitpretty='gitk'                      # Pretty git display using wish
alias app='open -a'                         # Open an application
alias updateDotfiles='~/Dotfiles/update.sh' # Update dotfiles
alias starwars='telnet towel.blinkenlights.nl'      # Watch Star Wars
alias beep="echo $'\a'"                     # Do a beep

#functions
cdls () { cd "$@" && ls ; }                  # cd and ls
trash () { mv "$@" ~/.Trash ; }              # Move a file to Trash
aliases () { cat ~/.bash_profile | grep -o --color=auto "^alias [\.A-Za-z0-9~]*" ; } # List all aliases found in this file
functions () { cat ~/.bash_profile | grep -o --color=auto "^[A-Za-z0-9]* ()" ; }      # List all functions found in this file
findPid () { lsof -t -c "$@" ; }             # Find Pid of specified process
displayPath () { for path in ${PATH//:/ }; do echo "$path"; done; }                  # Print path separated by newlines
mkcd () { mkdir "$@" && cd "$@" ; }          # mkdir and cd
editall () { vim -p "$@" ; }                 # edit all files provided as arguments in vim tabs
extract () {                                 # attempt to extract file with correct extraction method
	if [ -f $1 ]; then
		case $1 in
			*.tar.bz2)	tar xjf $1		;;
			*.tar.gz)	tar xzf $1		;;
			*.bz2)		bunzip2 $1		;;
			*.rar)		rar x $1		;;
			*.gz)		gunzip $1		;;
			*.tar)		tar xf $1		;;
			*.tbz2)		tar xjf $1		;;
			*.tgz)		tar xzf $1		;;
			*.zip)		unzip $1		;;
			*.Z)		uncompress $1	;;
			*)			echo "'$1' cannot be extracted via extract()" ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}

pathadd() {                                 # add to path
	if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
		PATH="${PATH:+"$PATH:"}$1"
	fi
}

# Setting PATH for Python 3.5
# The original version is saved in .bash_profile.pysave
pathadd "/Library/Frameworks/Python.framework/Versions/3.5/bin"

# Setting PATH for Python 2.7
# The original version is saved in .bash_profile.pysave
pathadd "/Library/Frameworks/Python.framework/Versions/2.7/bin"

# Set PATH for scala
pathadd "/Users/Knoble/scala-2.11.8/bin"

# Add bin folder for scripts to path
pathadd "$HOME/bin"
