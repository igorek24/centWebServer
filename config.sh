#!/bin/bash

# Admin user with sudo permissions, it will be used by admin to posibly
# deploy/change code and not prevent none sudo user from change files that's
# modified by admin.
# NOTE: If user doesn't exist, it will be created.
SYS_ADMIN_USER="noadmin"
# User without sudo, it will be used by developers to deploy code.
# NOTE: If user doesn't exist, it will be created.
SYS_USER="webadmin" # Default value is: webadmin
# Group to use for web admins. Members of this group will have r/w permissions
# to $WEB_ROOT_DIR directory. LUCEE_USER and apache also will be members of this
# group.
# NOTE: If group doesn't exist, it will be created.
WEB_ADMIN_GROUP="webadmins" # Default value is: webadmins
# This is the directory, where Apache VirtualServers applications will be stord.
# NOTE: Do not add trailing slash [/] after the folder. It may brake the script.
WEB_ROOT_DIR="/var/www/public_html" # Default value is: /var/www/public_html
# This email will replace Apache default root@localhost when error occurred.
HTTPD_WEBMASTER="webmaster@exemple.com"
# Enter your domain without www. EXEMPLE: mydomain.com
APP_DOMAIN_NAME="exemple.com"
# Enter your alias . EXEMPLE: www.mydomain.com OR dev.mydomain.com
APP_ALIAS="www.exemple.com"
################################################################################
#                             PHP Configuration                                #
################################################################################
# You may add requaerd PHP modules here.
# NOTE: You can see all module by running "yum search php-" in terminal.
PHP_MODS_INSTALL="php php-gd php-ldap php-odbc php-pear php-xml php-xmlrpc php-mbstring php-snmp php-soap curl curl-devel php-mysqli"
# PHP maximum allowed size for uploaded files.
# For more info, visit http://php.net/upload-max-filesize
# NOTE: You can use "M" for MeagaBites or "G" for Gigabytes.Default is 2M.
PHP_UPLOAD_MAX_FILESIZE="256M"
# Change php memory limit.
# NOTE: You can use "M" for MeagaBites or "G" for Gigabytes.Default is 2M.
# NOTE: Default value is 128M.
PHP_MEMORY_LIMIT="512M"
# Change php post_max_size.
# NOTE: You can use "M" for MeagaBites or "G" for Gigabytes.Default is 2M.
# NOTE: It must be equal or greater than upload_max_filesize. Default value
# is 8M
PHP_POST_MAX_SIZE="256M"
# Defines the default timezone used by the date functions.
# For more info, visit http://php.net/date.timezone
# For List of Supported Timezones visit http://php.net/manual/en/timezones.php
PHP_DATE_TIME="America/Los_Angeles"
# Decides whether PHP may expose the fact that it is installed on the server
# (e.g. by adding its signature to the Web server header).  It is no security
# threat in any way, but it makes it possible to determine whether you use PHP
# on your server or not. For more info, visit http://php.net/expose-php
PHP_EXPOSE_PHP="Off"
################################################################################
#                   MySQL Server Configuration Selection                       #
################################################################################
# Select wich flavor of MySQL server you would like to install.
# MariaDB - MariaDB from CentOS repo.
# MariaDB-Repo - MariaDB from MariaDB repo Newest stable.
# Percona - Percona MySQL server from Percona repo.
# MySQL - MySQL server from Oracle
# Change to your prefered (MariaDB, MariaDB-Repo, Percona, MySQL)
SELECT_MYSQL_SERVER="MariaDB-Repo"
################################################################################
#                        Custome firewall Configuration                        #
################################################################################

############### DO NOT CHANGE ANYTHING BELOW, UNLESS YOU KNOW WHAT YOU ARE DOING ###############

# Terminal Text Colors and Fonts
RCol='\e[0m'    # Text Reset
# Regular           Bold                Underline           High Intensity      BoldHigh Intens     Background          High Intensity Backgrounds
Bla='\e[0;30m';     BBla='\e[1;30m';    UBla='\e[4;30m';    IBla='\e[0;90m';    BIBla='\e[1;90m';   On_Bla='\e[40m';    On_IBla='\e[0;100m';
Red='\e[0;31m';     BRed='\e[1;31m';    URed='\e[4;31m';    IRed='\e[0;91m';    BIRed='\e[1;91m';   On_Red='\e[41m';    On_IRed='\e[0;101m';
Gre='\e[0;32m';     BGre='\e[1;32m';    UGre='\e[4;32m';    IGre='\e[0;92m';    BIGre='\e[1;92m';   On_Gre='\e[42m';    On_IGre='\e[0;102m';
Yel='\e[0;33m';     BYel='\e[1;33m';    UYel='\e[4;33m';    IYel='\e[0;93m';    BIYel='\e[1;93m';   On_Yel='\e[43m';    On_IYel='\e[0;103m';
Blu='\e[0;34m';     BBlu='\e[1;34m';    UBlu='\e[4;34m';    IBlu='\e[0;94m';    BIBlu='\e[1;94m';   On_Blu='\e[44m';    On_IBlu='\e[0;104m';
Pur='\e[0;35m';     BPur='\e[1;35m';    UPur='\e[4;35m';    IPur='\e[0;95m';    BIPur='\e[1;95m';   On_Pur='\e[45m';    On_IPur='\e[0;105m';
Cya='\e[0;36m';     BCya='\e[1;36m';    UCya='\e[4;36m';    ICya='\e[0;96m';    BICya='\e[1;96m';   On_Cya='\e[46m';    On_ICya='\e[0;106m';
Whi='\e[0;37m';     BWhi='\e[1;37m';    UWhi='\e[4;37m';    IWhi='\e[0;97m';    BIWhi='\e[1;97m';   On_Whi='\e[47m';    On_IWhi='\e[0;107m';
