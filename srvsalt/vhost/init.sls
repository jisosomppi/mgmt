# Package

apache2:
  pkg.installed:

# File

/etc/hosts:
  file.managed:
    - source: salt://vhost/hosts

/etc/apache2/sites-available/000-default.conf:
  file.managed:
    - source: salt://vhost/000-default.conf

# Service

apache2:
  service.running:
    - watch:
      - file: /etc/apache2/sites-available/000-default.conf
