# This is a module for installing and setting up Samba file server
# Jussi Isosomppi, 2018

samba:
  pkg.installed

/etc/samba/smb.conf:
  file.managed:
    - source: salt://samba/smb.conf

/srv/samba/public/publicfile.txt:
  file.managed:
    - source: salt://samba/publicfile.txt
    - makedirs: True

/srv/samba/secret/secretfile.txt:
  file.managed:
    - source: salt://samba/secretfile.txt
    - makedirs: True

# Grant rights to folders
sudo chmod -R 0777 /srv/samba:
  cmd.run

# Create users on target minion
secret:
  group.present

{% for user, args in pillar['users'].iteritems() %}
{{ user }}:
  user.present:
    - home: {{ args['home'] }}
    - shell: {{ args['shell'] }}
    - password: {{ args['password'] }}
    - enforce_password: False
    - groups:
      - {{ args['groups'] }}
{% endfor %}

smbd:
  service.running:
    - watch:
      - file: /etc/samba/smb.conf
