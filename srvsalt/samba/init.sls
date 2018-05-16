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

jussi:
  user.present:
    - shell: /bin/bash
    - home: /home/user1
    - groups:
      - secret

smbd:
  service.running:
    - watch:
      - file: /etc/samba/smb.conf
