export PATH=$HOME/bin:/home/mozartfalcao/.cargo/bin:$PATH

alias aliases='code /home/mozartfalcao/.oh-my-zsh/custom/aliases.zsh'
alias r='source ~/.zshrc'
alias cls='clear'
alias gs='google'  
alias yt='youtube'
alias fetch='neofetch'
alias exp='nautilus --select this&'
alias py='python3'
alias tx='tmux'
alias myip='curl https://checkip.amazonaws.com'

## Colorize the ls output ##
alias ls='ls --color=auto'
 
## Use a long listing format ##
alias ll='ls -la'
 
## Show hidden files ##
alias l.='ls -d .* --color=auto'

# reboot / halt / poweroff
alias reboot='sudo /sbin/reboot'
alias poweroff='sudo /sbin/poweroff'
alias halt='sudo /sbin/halt'
alias shutdown='sudo /sbin/shutdown'
alias shut='sudo shutdown -h now'
alias new-alias='nano ~/.oh-my-zsh/custom/aliases.zsh'
alias hibernate='sudo systemctl hibernate'

## distrp specifc RHEL/CentOS ##
alias update='yum update'
alias updatey='yum -y update'
alias inst='sudo dnf install'

# install  colordiff package :)
alias diff='colordiff'

## Colorize the grep command output for ease of use (good for log files)##
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'


## get rid of command not found ##
alias cd..='cd ..'
 
## a quick way to get out of current directory ##
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'

alias wks='cd ~/wks'

alias matrix='cmatrix'

alias docker='sudo docker'
alias docker-start='sudo systemctl start docker'
alias vsnet='vsc --profile net .'

alias generate-hiring-test-sharp='. ~/wks/scripts/generate-solution-sharp.sh'

