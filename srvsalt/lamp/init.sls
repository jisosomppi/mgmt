# Package

install_lamp:
  pkgs.installed:
    - apache2
    - libapache2-mod-php

# File

/var/www/html/index.php:
  file.managed:
    - source: salt://lamp/public_index.php

/etc/skel/public_html/index.php:
  file.managed:
    - source: salt://lamp/user_index.html

/etc/apache2/mods-available/php7.0.conf:
  file.managed:
    - source: salt://lamp/php7.0.conf

/etc/apache2/mods-enabled/userdir.conf:
  file.symlink:
    - target: ../mods-available/userdir.conf

/etc/apache2/mods-enabled/userdir.load:
  file.symlink:
    - target: ../mods-available/userdir.load

# Service

apache2:
 service.running:
   - watch:
     - file: /etc/apache2/mods-enabled/userdir.conf
     - file: /etc/apache2/mods-enabled/userdir.load
     - file: /etc/apache2/mods-available/php7.0.conf
