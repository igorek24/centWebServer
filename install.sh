#!/bin/bash
# Including config file.
. ./config.sh
. ./functions.sh
# root permission check.
if [ "$(whoami)" != "root" ]; then
  dialog --title "Error!" --msgbox "Sorry, you need to run this script continue sudo or as \"root\"." 6 65
	exit
fi

# Installing dependantcies for this script.
yum -y install dialog nano wget
# Asking user to update system.
dialog --title "System update?" \
--backtitle "CentOS 7 Configuration Utility" \
--yesno "Would you like to update the system?" 10 60

update_response=$?
  case $update_response in
    0) echo "Ok, smart move, lets update." ;
    yum -y update
    ;;
    1) echo "Skipping system update.";;
    255) echo "[ESC] key pressed.";;
  esac
# Installing Apache and mod_ssl.
dialog --title "Install Apache?" \
--backtitle "CentOS 7 Configuration Utility" \
--yesno "Would you like to Install Apache (httpd)? Select [Yes] to continue or [No] to skip this step." 10 60

install_httpd_response=$?
case $install_httpd_response in
   0)  install_httpd ; bck_httpd_confs ; httpd_conf;;
   1) echo "Apache installation skipped.";;
   255) echo "[ESC] key pressed.";;
esac
# Installing custom errors.
dialog --title "Install custom errors?" \
--backtitle "CentOS 7 Configuration Utility" \
--yesno "Would you like to Install custom error pages? Select [Yes] to continue or [No] to skip this step." 10 60

install_custom_errors_response=$?
case $install_custom_errors_response in
   0)  httpd_custom_error;;
   1) echo "Custome error pages installation skipped.";;
   255) echo "[ESC] key pressed.";;
esac
# Installing PHP.
dialog --title "Install PHP?" \
--backtitle "CentOS 7 Configuration Utility" \
--yesno "Would you like to Install PHP? Select [Yes] to continue or [No] to skip this step." 10 60

install_php_response=$?
case $install_php_response in
   0)  install_php ; php_conf;;
   1) echo "PHP installation skipped.";;
   255) echo "[ESC] key pressed.";;
esac
# Apache restart
httpd_restart
# Installing MySQL Server.
dialog --title "Install MySQL Server?" \
--backtitle "CentOS 7 Configuration Utility" \
--yesno "Would you like to Install MySQL Server? Select [Yes] to continue or [No] to skip this step." 10 60

install_mysql_response=$?
case $install_mysql_response in
   0)  install_mysql ; mysql_secure_installation;;
   1) echo "PHP installation skipped.";;
   255) echo "[ESC] key pressed.";;
esac
# Configure Firewall
dialog --title "Cinfigure Firewall" \
--backtitle "CentOS 7 Configuration Utility" \
--yesno "Would you like us to configure firewall? We will open HTTP (port 80) and HTTPS (port 443) Select [Yes] to continue or [No] to skip this step." 10 60

firewall_response=$?
case $firewall_response in
   0)  firewall_conf;;
   1) echo "Firewall configuration skipped.";;
   255) echo "[ESC] key pressed.";;
esac

USER_CHECK
GROUP_CHECK
httpd_webroot_dir
web_admins_permissions
httpd_selinux
