# shell scripting 🐧

## d-mysql

Usage : `d-myql version`

Exemple : `d-mysql 8.0`

A script which run a docker container for few mysql version. With it, it's easier to switch between versions.

Stops mysql service if needed.

See [crazy-lemp project](https://github.com/LeFodeurCou/crazy-lemp) on my GitHub if you want a more complete version.

## serviceExists

Usage : `serviceExists serviceName`

Exemple : `serviceExists mysql`

Show "Yes" if service exists or "No" if it doesn't

## addrMacWireless

Usage : `addrMacWireless`

Show your address mac. Wireless is a reminder for why I crated this script.

## archive

Usage : `archive file` / `archive tarballName fileOrFolder`

Unzip or untar an archive file. Or tar files or folders to tarball.

## addUserToApachGroup

Usage : `addUserToApachGroup`

To apache server users. Does what its name say.

## d-php

Usage : `d-php version`

Exemple : `d-php 8.0`

A script which run a docker container for few php version. With it, it's easier to switch between versions.

Stops php service if needed.

See [crazy-lemp project](https://github.com/LeFodeurCou/crazy-lemp) on my GitHub if you want a more complete version.

## lastModif

USage : `lastModif`

Show last ten files modified by date order from most recent to the least.

## npm-init

Usage `npm-init [optionnal]`

Use npm to init the repository and add some scripts in package.json for automation purposes.

It setups Babel, Parcel, SASS allowing you to work with what you want.

It accept two parameters : `git` and `react`

First does only `git init`

Second is more useful because it setups your working directory to use ReactJs without create a whole React application (Yes you can do it 😎 See my [CodePen](https://codepen.io/LeFodeurCou/pen/XWMOjjX) to learn how it works).

Scripts injected in package.json are npm cross-plateforme packages :)
I know, this script is only for Linux bash users :trollface:

## vhostCreate

Usage : `vhostCreate vhostName [optionnal]`

Exemples : `vhostCreate test` / `vhostCreate demo dev`

Creates respectively test.local and demo.dev.local virtual hosts for apache server. It creates configurations files, adds a line in /etc/hosts to match the vhost with your localhost and creates a specific folder in ~/dev.

Why in ~/dev and not in /var/www/html/ ? 

Because I have a symbolic link for ~/dev folder in /var/www/html/ 🙃 It works well and so you can work where you want 🎉

-------------------------------------------------

# ~/.bashrc

Last but not least, I joined a part of my ~/.bashrc file with prompt exemple if you are looking for it, some functions working like shell scripts and aliases (they can be shell scripts in other hand).

It also contains some aliases. I will explain all functions and aliases now 😉

## parse_git_branch

```
function parse_git_branch()
{
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}
```

Used in my prompt (yes you can) in order to display current git branch directly in terminal 💪

## lgrep

```
function lgrep()
{
	if [ -z "$1" ]
	then
		echo "Missing argument 1"
	else
		grep -Rn "$1" .
	fi
}
```

Now I have `grep -Rn` in my memory but I use always this function if I am searching for a word or an expression in current directory files (and also sub-directories).

I think it's the first command I use when I am coding 😇

Bonus - Combo with `find` to search in specifics files :
`find . -name '*.js' -exec grep -Rn {} --color=auto +`
It save the case you are searching for a classname by exemple and `grep` search in all files, css, html, js or other while you want only search in js files.

## save

```
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
```

I have not used this for a while, but it may be useful to avoid some mistakes.

It makes a copy of targeted file with '.save' added at the end of its name.

The `sudo` usage allow you to use it where you want.

## phpSwitch

```
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
```

Before I have a script to use easily php docker container, I used this to switch between installed php versions.

The truth ? I still use it 🐒

## setGoodChmod, setGoodChown and setGood

```
function setGoodChmod()
{
	sudo find . -type f -exec chmod 666 {} \; && sudo find . -type d -exec chmod 775 {} \;
}
```

```
function setGoodChown()
{
	sudo find . -exec chown -R www-data:www-data {} \;
}
```

```
function setGood()
{
	setGoodChmod;
	setGoodChown;
}
```

First sets `chmod` for current directory and sub-directories recursively.
Second does almost the same, but for `chown`.
Last does both.

It's useful when you work with a soft that needs specific rights on your files (like apache 🤔)

## nbrLines

```
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
```
😅
Just a line counter, default if for php files but you can use it for all files you want if they have same extension (.js, .sh, .yml etc.)

## cdSpecial

```
function cdSpecial()
{
	if [ -n "$1" ]
	then
		\cd "$1" && clear && ls -ilath;
	else
		\cd /home/${USER}/ && clear && ls -ilath;
	fi
}
```

A function that wanted to be a built-in instead of a built-in 😎

It is useful for recursive `cd` use and to add `clear` and some option to `ls`. I use it for my aliases.

## mk
```
function mk()
{
	if [ -n "$1" ]
	then
		mkdir -pv "$1" && cd "$_"
	else
		echo $RED"You need one parameter"$NORMAL
	fi
}
```
Instead of `mkdir`. May create directory and sub-directories and use `cd` to go directly in.

## Aliases

```
alias bashrc='code ~/.bashrc'
alias source='source ~/.bashrc'
```
To edit easily ~/.basrch file and update current shell with last modifications.

```
alias cd:='cd ../'
alias cd::='cd ../../'
alias cd:::='cd ../../../'
alias cd::::='cd ../../../../'
alias cd:::::='cd ../../../../../'
alias cd-='cd -'
alias cd='cdSpecial'
```
Because it's possible :trollface: And faster. Very faster than normal use of `cd`.
See the usage of `cdSpecial`. Without it doesn't work.

```
alias dev='cd ~/dev/'
alias bin='cd ~/bin/'
alias doc='cd ~/Documents/'
alias tst='cd ~/tmp/test/'
alias tools='cd ~/dev/tools/'
alias trash='cd ~/.local/share/Trash/files/'
```
Other `cd` aliases. To be honnest I mostly use dev and a little bin when I need it, else I use a "classic command".

```
alias ll='clear && ls -ilaths --color=auto'
alias l='ll'
```
`ls` aliases. `l` is two times faster than `ll` ! Amazing ! 😂
Show more useful data than just `ls` like rights, weight etc. Obviously show hidden files (like .bashrc)

`alias untar='tar -xf'`

I used it before I did `archive` script.

`alias py='python3.6'`

To summon a snake versione 3.6 :trollface:
More seriously, if you don't know what is Python, go google it 😉

`alias build='npm run build'`
No longer in use, but it was useful in its time.

`alias shells='cat /etc/shells'`

Show shells which are available on your machine. Interesting 🕵️

`alias ports="sudo lsof -i -P  | grep -i 'listen'"`

Show what ports are open on your machine and which application are using them.

`alias os='clear && cat /etc/os-release'`

Show informations about your Operating System

```
alias log='clear && sudo cat /var/log/apache2/error.log | sed "s/\[\(.*\)\] \[\(.*\)\] \[\(.*\)\] \[\(.*\)\] /$BOLD$GREEN\1 $RED\2 $GREEN\3 $BLUE\4$WHITE \n\n/g" | sed "s/\(line.*\)/$RED\1$WHITE$NORMAL\n/g" | sed "s/\(\.local\)\(.*\.php\)/\1$MAGENTA\2$WHITE/g"'
```

Wow regex in aliases thank to `sed` 😎
Display the content of your apache log. Useful when you have only a white page when you devlop your web site.
Also, color it. Globaly it is a more friendly view than just `cat` the file.
(may be you need to change the exact file to make it work).

```
alias rmLog='sudo rm -rf /var/log/apache2/error.log && sudo service apache2 restart'
```
When you have too many logs. After you will not have any logs. 💥

```
alias glog="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
```
If you use git like a pro (in terminal ? 😇), it may be useful to display the git commit historic in a more friendly view (may not be visualy better than a graphical tool, but it is here).

```
alias gchmod="git config core.fileMode false"
```
Veeeery useful in order to ignore rights changes when you use `git add .` !!! Avoid the billion of files to commit after used `chmod` ...

```
alias codeExt="code --list-extensions | xargs -L 1 echo code --install-extension"
```
Fun and allow you to share your VSCode plugins 😄

```
alias getPublicIP="hostname -I | cut -d ' ' -f1"
```
Get your public IP. Not only for Minecraft.

```
alias nbrShLines="find . -maxdepth 1 -perm -1 -type f -exec cat {} + | wc -l"
```

Like function nbrLine but only for shell scripts and without use `.sh` at the end

## 🔐 License

MIT

-------------------
## 📢 Last word

Don't forget, be crazy 💥💥💥
