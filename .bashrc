RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
WHITE=$(tput setaf 7)
_RESET=$(tput sgr0)
BOLD=$(tput bold)

if [ "color_prompt" = yes ]; then
	PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
	PS1='┌─[ $BOLD$RED\$\033[0m ][$BOLD$YELLOW \t \033[0m]
| [ $BOLD$BLUE\w\033[0m ]
| [$BOLD Git branch : $GREEN$(parse_git_branch)\033[0m ]
└─\[$BOLD\]> \[\033[0m\]'
fi
unset color_prompt force_color_prompt

function parse_git_branch()
{
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

function lgrep()
{
	if [ -z "$1" ]
	then
		echo "Missing argument 1"
	else
		grep -Rn "$1" .
	fi
}

function save()
{
	if [ -n "$1" ]
	then
		ROOT=`echo "$1" | cut -d'.' -f1`
		sudo cp -R "$1" ${ROOT}".save"
	else
		echo "Missing source argument"
	fi
}

function phpSwitch()
{
	if [ -n "$1" ]
	then
		sudo a2dismod php5.6
		sudo a2dismod php7.2
		sudo a2dismod php7.3
		sudo a2dismod php7.4
		sudo a2dismod php8.0
		if [ "$1" == "5.6" ]
		then
			sudo a2enmod php5.6
			sudo update-alternatives --set php /usr/bin/php5.6
		elif [ "$1" == "7.2" ]
		then
			sudo a2enmod php7.2
			sudo update-alternatives --set php /usr/bin/php7.2
		elif [ "$1" == "7.3" ]
		then
			sudo a2enmod php7.3
			sudo update-alternatives --set php /usr/bin/php7.3
		elif [ "$1" == "7.4" ]
		then
			sudo a2enmod php7.4
			sudo update-alternatives --set php /usr/bin/php7.4
		elif [ "$1" == "8.0" ]
		then
			sudo a2enmod php8.0
			sudo update-alternatives --set php /usr/bin/php8.0
		fi
		sudo service apache2 restart
	else
		echo "You need to choose a php version"
	fi
}

function setGoodChmod()
{
	sudo find . -type f -exec chmod 666 {} \; && sudo find . -type d -exec chmod 775 {} \;
}

function setGoodChown()
{
	sudo find . -exec chown -R www-data:www-data {} \;
}

function setGood()
{
	setGoodChmod;
	setGoodChown;
}

function nbrLines()
{
	res=0
	if [ -z "$1" ]
	then
		var="php";
	else
		var="$1";
	fi
	for f in `find . -type f -name "*.""$var"`; 
	do
		let " res += `wc -l $f | awk '{print $1}'`  ";
	done
	echo $res
}

function cdSpecial()
{
	if [ -n "$1" ]
	then
		\cd "$1" && clear && ls -ilath;
	else
		\cd /home/${USER}/ && clear && ls -ilath;
	fi
}

function mk()
{
	if [ -n "$1" ]
	then
		mkdir -pv "$1" && cd "$_"
	else
		echo $RED"You need one parameter"$NORMAL
	fi
}

alias bashrc='code ~/.bashrc'
alias source='source ~/.bashrc'
alias cd:='cd ../'
alias cd::='cd ../../'
alias cd:::='cd ../../../'
alias cd::::='cd ../../../../'
alias cd:::::='cd ../../../../../'
alias cd-='cd -'
alias cd='cdSpecial'
alias dev='cd ~/dev/'
alias bin='cd ~/bin/'
alias doc='cd ~/Documents/'
alias tst='cd ~/tmp/test/'
alias tools='cd ~/dev/tools/'
alias trash='cd ~/.local/share/Trash/files/'
alias ll='clear && ls -ilaths --color=auto'
alias l='ll'
alias untar='tar -xf'
alias py='python3.6'
alias build='npm run build'
alias shells='cat /etc/shells'
alias ports="sudo lsof -i -P  | grep -i 'listen'"
alias os='clear && cat /etc/os-release'
alias log='clear && sudo cat /var/log/apache2/error.log | sed "s/\[\(.*\)\] \[\(.*\)\] \[\(.*\)\] \[\(.*\)\] /$BOLD$GREEN\1 $RED\2 $GREEN\3 $BLUE\4$WHITE \n\n/g" | sed "s/\(line.*\)/$RED\1$WHITE$NORMAL\n/g" | sed "s/\(\.local\)\(.*\.php\)/\1$MAGENTA\2$WHITE/g"'
alias rmLog='sudo rm -rf /var/log/apache2/error.log && sudo service apache2 restart'
alias glog="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
alias gchmod="git config core.fileMode false"
alias codeExt="code --list-extensions | xargs -L 1 echo code --install-extension"
alias getPublicIP="hostname -I | cut -d ' ' -f1"
alias nbrShLines="find . -maxdepth 1 -perm -1 -type f -exec cat {} + | wc -l"