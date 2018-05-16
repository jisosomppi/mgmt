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

secret:
  group.present:
    - gid: 1337
    - system: True

{% for group, args in pillar['fs'].iteritems() %}
{{ group }}:
  group.present:
    - name: {{ group }}
    - gid: {{ args['gid'] }}

{% for user, args in pillar['fs'].iteritems() %}
{{ user }}:
  group.present:
    - gid: {{ args['gid'] }}
  user.present:
    - home: {{ args['home'] }}
    - shell: {{ args['shell'] }}
    - uid: {{ args['uid'] }}
    - gid: {{ args['gid'] }}

jussi:
  user.present:
    - uid: 1001
    - shell: /bin/bash
    - home: /home/jussi
    - groups:
      - secret

markku:
  user.present:
    - uid: 1002
    - shell: /bin/bash
    - home: /home/markku
    - groups:
      - secret


smbd:
  service.running:
    - watch:
      - file: /etc/samba/smb.conf
