/etc/samba/smb.conf:
  file.managed:
    - source salt://samba/smb.conf

/srv/samba/public/publicfile.txt:
  file.managed:
    - source: salt://samba/publicfile.txt
    - makedirs: True

/srv/samba/secret/secretfile.txt:
  file.managed:
    - source: salt://samba/secretfile.txt
    - makedirs: True

jussi:
  user.present:
    shell: /bin/bash
    home: /home/user1
    groups:
      - secret

smbd:
  service.running:
    - watch:
      - file: /etc/samba/smb.conf
