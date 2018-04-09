# Package

install_apache:
  pkg.installed:
    - pkgs:
      - apache2
      - libapache2-mod-php

# File

/var/www/html/index.php:
  file.managed:
    - source: salt://apache/public_index.php

/etc/skel/public_html/index.php:
  file.managed:
    - source: salt://apache/user_index.php
    - makedirs: True

/etc/apache2/mods-available/php7.0.conf:
  file.managed:
    - source: salt://apache/php7.0.conf

/etc/apache2/mods-enabled/userdir.conf:
  file.symlink:
    - target: ../mods-available/userdir.conf

/etc/apache2/mods-enabled/userdir.load:
  file.symlink:
    - target: ../mods-available/userdir.load

# Service

apache2service:
  service.running:
    - name: apache2
    - watch:
      - file: /etc/apache2/mods-enabled/userdir.conf
      - file: /etc/apache2/mods-enabled/userdir.load
      - file: /etc/apache2/mods-available/php7.0.conf
