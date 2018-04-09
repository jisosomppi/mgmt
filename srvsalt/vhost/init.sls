# Package

apache2:
  pkg.installed:

# File

/etc/hosts:
  file.managed:
    - source: salt://vhost/hosts

/etc/apache2/sites-available/000-default.conf:
  file.managed:
    - source: salt://vhost/testi.sivu.conf

# Service

apache2service:
  service.running:
    - name: apache2
    - watch:
      - file: /etc/apache2/sites-available/000-default.conf
