# centWebServer


## Configure Web Server on CentOS 7 in seconds.

---

What would take hours to do manualy, can be done in under 60 seconds (depending on your hardware and internet speed).

### How to use it.

Edit config.sh to your needs. For the most part defaults should be OK besides "HTTPD_WEBMASTER", "APP_DOMAIN_NAME", "APP_ALIAS" and "PHP_DATE_TIME".

```
# git clone https://git.theigor.net/igorek24/centWebServer.git
# cd centWebServer
# sh install.sh
```
And just ansare "YES" or "NO".

Here what it will do if you select "YES" to all of the prompts

1. System
  * Install  dialog, nano and wget.
  * Update (yum update).
2. Apache
  * Install httpd, mod_ssl.
  * Backup all files that this script modifies.
  * Changes ServerName to localhost:80
  * Changes ServerAdmin email to specied in config.sh
  * Adds index.php to DirectoryIndex
  * Adds  ServerSignature to Off
  * Adds  ServerTokens to Prod
  * Adds  TraceEnable to Off
  * Adds  SetOutputFilter to DEFLATE
3. Custom Error Pages
  * Changes default noindex index.html
  * Creates 400.htm, 401.html, 403.html, 404.html, 405.html,500.html 502.html and 503.html files in "/usr/share/httpd/custom_error/" directory.
4. PHP
  * Insalls php and php modules specified in config.sh
  * Changes upload_max_filesize to value specified in config.sh
  * Changes memory_limit to value specified in config.sh
  * Sets date.timezone to value specified in config.sh
  *Changes expose_php to value specified in config.sh
  * Changes post_max_size to value specified in config.sh
5. MySQL Server
  * Installs MySQL 5.x / MAriaDB 5.x / MariaDB 10.x / Percona MySQL (You can choose preferd flavor in config.sh.
  * Runns mysql_secure_installation

___

<img src="https://www.theigor.net/imgs/var/resizes/My-Projects/centWebServer/img14.png">

<img src="https://www.theigor.net/imgs/var/resizes/My-Projects/centWebServer/img13.png">

<img src="https://www.theigor.net/imgs/var/resizes/My-Projects/centWebServer/img12.png">

<img src="https://www.theigor.net/imgs/var/resizes/My-Projects/centWebServer/img11.png">

<img src="https://www.theigor.net/imgs/var/resizes/My-Projects/centWebServer/img10.png">

<img src="https://www.theigor.net/imgs/var/resizes/My-Projects/centWebServer/img9.png">

<img src="https://www.theigor.net/imgs/var/resizes/My-Projects/centWebServer/img8.png">

<img src="https://www.theigor.net/imgs/var/resizes/My-Projects/centWebServer/img7.png">

<img src="https://www.theigor.net/imgs/var/resizes/My-Projects/centWebServer/img6.png">

<img src="https://www.theigor.net/imgs/var/resizes/My-Projects/centWebServer/img5.png">

<img src="https://www.theigor.net/imgs/var/resizes/My-Projects/centWebServer/img4.png">

<img src="https://www.theigor.net/imgs/var/resizes/My-Projects/centWebServer/img3.png">

<img src="https://www.theigor.net/imgs/var/resizes/My-Projects/centWebServer/img2.png">

<img src="https://www.theigor.net/imgs/var/resizes/My-Projects/centWebServer/img1.png">
