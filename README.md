# shell-scripting 🐧

Some scripts shell and aliases to keep your life easy and fun.

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

Bonus - Combo with find to search in specifics files :
`find . -name '*.js' -exec grep -Rn {} --color=auto +`
It save the case you are searching for a classname by exemple and grep search in all files, css, html, js or other while you want only search in js files.

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
