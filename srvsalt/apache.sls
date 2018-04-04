apache2:
  pkg.installed

/var/www/html/index.html:
 file.managed:
   - source: salt://apache/default-index.html

a2enmod userdir:
 cmd.run:
   - creates: /etc/apache2/mods-enabled/userdir.conf

apache2service:
 service.running:
   - name: apache2
   - watch:
     - cmd: 'a2enmod userdir'
