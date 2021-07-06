# shell-scripting
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

