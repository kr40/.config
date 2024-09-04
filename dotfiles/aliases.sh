#! /bin/bash

# Alias's for exa
alias ls='exa -halF --color=always --group-directories-first --icons --time-style=iso' # my preferred listing
alias la='exa -a --color=always --group-directories-first --icons --time-style=iso'    # all files and dirs
alias ll='exa -l --color=always --group-directories-first --icons --time-style=iso'    # long format
alias lt='exa -aT --color=always --group-directories-first --icons --time-style=iso'   # tree listing
alias l.='exa -a | egrep "^\."'

# Alias's for update and upgrade
alias upd='sudo apt update'
alias upg='sudo apt full-upgrade -y'
alias distupg='sudo apt update && sudo apt full-upgrade && sudo apt dist-upgrade -y'
alias autorm='sudo apt autoremove'
alias autocl='sudo apt autoclean'
alias ins='sudo apt install -y '
alias un='sudo apt remove -y '

# Alias's for clear & exit
alias c='clear'
alias e='exit'

# Global Variables
export FD_OPTIONS="--hidden --follow --exclude .git --exclude node_modules --ignore-file $HOME/.config/dotfiles/ignore"
export PATH=$PATH:/home/kr40/Desktop/scripts
export FZF_DEFAULT_COMMAND="git ls-files --cached --others --exclude-standard 2>/dev/null || fd --type f --type l $FD_OPTIONS"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d $FD_OPTIONS"
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/.ripgreprc"
export BAT_THEME=Dracula
export BAT_PAGER="less --RAW-CONTROL-CHARS --quit-if-one-screen --chop-long-lines"
export BAT_TABS="2"

# Alias for fd
alias fd="fd $FD_OPTIONS"

# Alias's for Batcat
alias bat='batcat'
alias gte='gnome-text-editor'

# Alias's for Lazygit
alias lg='lazygit'

# Alias's for cht.sh
alias cht='cht.sh'
alias chts='cht.sh --shell'

# Alias's for TMUX
alias t="tmux"
alias ta="t a -t"
alias tls="t ls"
alias tn="t new -t"

# Alias's to modified commands
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -iv'
alias mkdir='mkdir -pv'
alias ps='ps auxf'
alias ping='ping -c 10'
alias less='less -R'

# Change directory aliases
alias home='cd ~'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias root='cd /'

alias rmd='/bin/rm  --recursive --force --verbose '

# alias chmod commands
alias mx='sudo chmod a+x'
alias 000='sudo chmod -R 000'
alias 644='sudo chmod -R 644'
alias 666='sudo chmod -R 666'
alias 755='sudo chmod -R 755'
alias 777='sudo chmod -R 777'

# Echo current IPv4 Address
alias myip="curl http://ipecho.net/plain; echo"

alias sbash='source ~/.bashrc'

# Search command line history
alias h="history | grep "

# Search running processes
alias p="ps aux | grep "
alias topcpu="/bin/ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10"

# Search files in the current folder
alias f="find . | grep "

# Count all files (recursively) in the current folder
alias countfiles="for t in files links directories; do echo \`find . -type \${t:0:1} | wc -l\` \$t; done 2> /dev/null"

# To see if a command is aliased, a file, or a built-in command
alias checkcommand="type -t"

# Kill any lingering SSH processes
function sshkill() { ps aux | grep ssh | grep -v grep | grep -v sshd | awk {'print $2'} | xargs -r kill -9; }

# Show active ports
alias port='netstat -tulanp'

# Use these for when the boss comes around to look busy.
alias busy="cat /dev/urandom | hexdump -C | grep 'ca fe'"
function busytext() { while true; do
  sleep .15
  head /dev/urandom | tr -dc A-Za-z0-9
done; }

# Print last value returned from previous command
alias lastvalue='RET=$?; if [[ $RET -eq 0 ]]; then echo -ne "\033[0;32m$RET\033[0m ;)"; else echo -ne "\033[0;31m$RET\033[0m ;("; fi; echo -n " "'

# Grab a pretty ascii forecast picture for anywhere; without arguments, uses ISP location to print your weather
# Example: weather New York, NY
function weather() { curl -s http://wttr.in/"$1"; }

# Convert hex data file to a binary
function hex2bin() {
  s=${@^^}
  for i in $(seq 0 1 $((${#s} - 1))); do printf "%04s" $(printf "ibase=16; obase=2; ${s:$i:1};\n" | bc); done
  printf "\n"
}

# Alias's for safe and forced reboots
alias rebootsafe='sudo shutdown -r now'
alias rebootforce='sudo shutdown -r -n now'

# Alias's to show disk space and space used in a folder
alias diskspace="du -S | sort -n -r |more"
alias folders='du -h --max-depth=1'
alias folderssort='find . -maxdepth 1 -type d -print0 | xargs -0 du -sk | sort -rn'
alias tree='tree -CAhF --dirsfirst'
alias treed='tree -CAFd'
alias mountedinfo='df -hT'

# Alias's for archives
alias mktar='tar -cvf'
alias mkbz2='tar -cvjf'
alias mkgz='tar -cvzf'
alias untar='tar -xvf'
alias unbz2='tar -xvjf'
alias ungz='tar -xvzf'

# Show all logs in /var/log
alias logs="sudo find /var/log -type f -exec file {} \; | grep 'text' | cut -d' ' -f1 | sed -e's/:$//g' | grep -v '[0-9]$' | xargs tail -f"

# SHA1
alias sha1='openssl sha1'

# FAST API (npm)
alias fast='fast -u'

# Alias to add hosts
alias hosts='sudo nvim /etc/hosts'

# Searches for text in all files in the current folder
ftext() {
  # -i case-insensitive
  # -I ignore binary files
  # -H causes filename to be printed
  # -r recursive search
  # -n causes line number to be printed
  # optional: -F treat search term as a literal, not a regular expression
  # optional: -l only print filenames and not the matching lines ex. grep -irl "$1" *
  grep -iIHrn --color=always "$1" . | less -r
}

# Copy file with a progress bar
cpp() {
  set -e
  strace -q -ewrite cp -- "${1}" "${2}" 2>&1 |
    awk '{
	count += $NF
	if (count % 10 == 0) {
		percent = count / total_size * 100
		printf "%3d%% [", percent
		for (i=0;i<=percent;i++)
			printf "="
			printf ">"
			for (i=percent;i<100;i++)
				printf " "
				printf "]\r"
			}
		}
	END { print "" }' total_size=$(stat -c '%s' "${1}") count=0
}

# Copy and go to the directory
cpg() {
  if [ -d "$2" ]; then
    cp $1 $2 && cd $2
  else
    cp $1 $2
  fi
}

# Move and go to the directory
mvg() {
  if [ -d "$2" ]; then
    mv $1 $2 && cd $2
  else
    mv $1 $2
  fi
}

# Create and go to the directory
mkdirg() {
  mkdir -p $1
  cd $1
}

# Goes up a specified number of directories  (i.e. up 4)
up() {
  local d=""
  limit=$1
  for ((i = 1; i <= limit; i++)); do
    d=$d/..
  done
  d=$(echo $d | sed 's/^\///')
  if [ -z "$d" ]; then
    d=..
  fi
  cd $d
}

# Automatically do an ls after each cd (Not working with oh-my-bash)
cd() {
  if [ -n "$1" ]; then
    builtin cd "$@" && ls
  else
    builtin cd ~ && ls
  fi
}

# Returns the last 2 fields of the working directory
pwdtail() {
  pwd | awk -F/ '{nlast = NF -1;print $nlast"/"$NF}'
}

# Extract most know archives with one command
ex() {
  if [ -f "$1" ]; then
    case $1 in
      *.tar.bz2) tar xjf $1 ;;
      *.tar.gz) tar xzf $1 ;;
      *.bz2) bunzip2 $1 ;;
      *.rar) unrar x $1 ;;
      *.gz) gunzip $1 ;;
      *.tar) tar xf $1 ;;
      *.tbz2) tar xjf $1 ;;
      *.tgz) tar xzf $1 ;;
      *.zip) unzip $1 ;;
      *.Z) uncompress $1 ;;
      *.7z) 7z x $1 ;;
      *.deb) ar x $1 ;;
      *.tar.xz) tar xf $1 ;;
      *.tar.zst) unzstd $1 ;;
      *) echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# For some reason, rot13 pops up everywhere
rot13() {
  if [ $# -eq 0 ]; then
    tr '[a-m][n-z][A-M][N-Z]' '[n-z][a-m][N-Z][A-M]'
  else
    echo $* | tr '[a-m][n-z][A-M][N-Z]' '[n-z][a-m][N-Z][A-M]'
  fi
}

# Trim leading and trailing spaces (for scripts)
trim() {
  local var=$@
  var="${var#"${var%%[![:space:]]*}"}" # remove leading whitespace characters
  var="${var%"${var##*[![:space:]]}"}" # remove trailing whitespace characters
  echo -n "$var"
}

# Zoxide config
eval "$(zoxide init bash)"

# pipx completion
eval "$(register-python-argcomplete pipx)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# Created by `pipx` on 2023-12-18 07:28:24
export PATH="$PATH:/home/kr40/.local/bin"

source /usr/share/doc/fzf/examples/key-bindings.bash
