#!/bin/bash
# In cluding config file.
. ./config.sh
# Install Apache function
install_httpd(){
  yum -y install httpd mod_ssl
  echo "Enabling Apache service to start at boot."
  systemctl enable httpd
}
# Backup httpd conf files function.
bck_httpd_confs(){
  if [ ! -d backup ]; then
  mkdir backup
  else
    echo "Folder alreadr exist. :-)"
  fi
  if [ ! -d backup/etc ]; then
  mkdir backup/etc
  else
  echo "Folder alreadr exist. :-)"
  fi
  if [ ! -d backup/etc/httpd ]; then
  mkdir backup/etc/httpd
  else
  echo "Folder alreadr exist. :-)"
  fi
  if [ ! -d backup/etc/httpd/conf.d ]; then
  mkdir backup/etc/httpd/conf.d
  else
  echo "Folder alreadr exist. :-)"
  fi
  if [ ! -d backup/etc/httpd/conf ]; then
  mkdir backup/etc/httpd/conf
  else
  echo "Folder alreadr exist. :-)"
  fi
  # Backup welcom.conf and remove it from httpd.
  if [ -f /etc/httpd/conf.d/welcome.conf ]; then
  mv /etc/httpd/conf.d/welcome.conf backup/etc/httpd/conf.d
  else
  echo "welcome.conf not found. :-)"
  fi
  # Backup Apache default config file.
  cp /etc/httpd/conf/httpd.conf backup/etc/httpd
  # Backup /etc/httpd/conf.d/autoindex.conf
  cp  /etc/httpd/conf.d/autoindex.conf backup/etc/httpd/conf.d/
}
# Apache Hardening function
httpd_hardening(){
  # Hide servers identity.
  sed -i "s/EnableSendfile on/EnableSendfile on \nServerSignature Off \nServerTokens Prod \nTraceEnable Off \nSetOutputFilter DEFLATE /g" /etc/httpd/conf/httpd.conf
  # Making Indexes Options look beter (Optinal, its recomended to disable Indexes option).
  sed -i "s/IndexOptions FancyIndexing HTMLTable VersionSort/IndexOptions IgnoreCase FancyIndexing FoldersFirst NameWidth=* DescriptionWidth=* SuppressHTMLPreamble /g" /etc/httpd/conf.d/autoindex.conf
  # Disabling Indexes option for defaul site.
  sed -i "s/Options Indexes FollowSymLinks/Options FollowSymLinks /g" /etc/httpd/conf/httpd.conf
  # Apache to listen on all IP adresses
  sed -i "s/Listen 80/Listen *:80 /g" /etc/httpd/conf/httpd.conf
  # Apache default site to localhost
  sed -i "s/#ServerName www.example.com:80/ServerName localhost:80 /g" /etc/httpd/conf/httpd.conf
  # Apache webmaster email address
  sed -i "s/ServerAdmin root@localhost/ServerAdmin $HTTPD_WEBMASTER/g" /etc/httpd/conf/httpd.conf
  # Add index.cfm to DirectoryIndex
  sed -i "s/DirectoryIndex index.html/DirectoryIndex index.html index.cfm/g" /etc/httpd/conf/httpd.conf
}
# httpd restart function
httpd_restart(){
  # Installing Apache and mod_ssl.
  dialog --title "Restart Apache?" \
  --backtitle "CentOS 7 Configuration Utility" \
  --yesno "Would you like to restart Apache service? Select [Yes] to restart or [No] to skip this step." 10 60

  httpd_restart_response=$?
  case $httpd_restart_response in
     0)  systemctl restart httpd;;
     1) echo "Apache service not restarted.";;
     255) echo "[ESC] key pressed.";;
  esac

}
# Checking if $SYS_USER exists and if not create it.
USER_CHECK(){
  if grep -c "^$SYS_USER:" /etc/passwd > 0; then
        echo "$SYS_USER user already exists"
      else
    	echo "$SYS_USER user does not exist, creating it."
      useradd $SYS_USER
    fi

}
# Checking if $WEB_ADMIN_GROUP exists and if not create it.
GROUP_CHECK(){
  if grep -c "^$WEB_ADMIN_GROUP:" /etc/group > 0; then
        echo "$WEB_ADMIN_GROUP group already exists"
      else
    	   echo "$WEB_ADMIN_GROUP group does not exist, creating it."
      groupadd $WEB_ADMIN_GROUP
    fi

}
#Checking if $WEB_ROOT_DIR exists and if not create it.
httpd_webroot_dir(){
  if [ -d $WEB_ROOT_DIR ]
    then
    chgrp $WEB_ADMIN_GROUP -R $WEB_ROOT_DIR
    chmod -R 775 $WEB_ROOT_DIR
  else
    echo "\"$WEB_ROOT_DIR\" does not exist!"
    echo "Lets create it."
    # Create web root directory.
    mkdir $WEB_ROOT_DIR
    chown -R apache:$WEB_ADMIN_GROUP $WEB_ROOT_DIR
    chmod -R 775 $WEB_ROOT_DIR
  fi
}
# Adding users to $WEB_ADMIN_GROUP group
web_admins_permissions(){
  gpasswd --add apache $WEB_ADMIN_GROUP
  gpasswd --add $SYS_ADMIN_USER $WEB_ADMIN_GROUP
  gpasswd --add $SYS_USER $WEB_ADMIN_GROUP
}
#Configuring Selinux.
httpd_selinux(){

  echo -e "${BYel}${On_Pur}Please wait, making your life easier by Configuring Selinux for you!${RCol}"
  chcon -R -u system_u -t httpd_sys_content_t $WEB_ROOT_DIR
  setsebool -P httpd_can_sendmail 1
  setsebool -P httpd_can_network_connect 1
  restorecon -R $WEB_ROOT_DIR
  echo "Done Configuring Selinux."
}
# Detecting arctiecture (if it's 64bit or 32bit), downloading and installing Lucee
install_php(){
  yum -y install php php-gd php-ldap php-odbc php-pear php-xml php-xmlrpc php-mbstring php-snmp php-soap curl curl-devel php-mysqli
}
#php_hardening(){

#}
