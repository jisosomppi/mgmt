# Pillar containing approved users for secret Samba share
# Jussi Isosomppi, 2018

# Passwords need to be created separately for each client using
# sudo salt '*' shadow.gen_password Password_goes_here
# and added here in place of the non-working, non-hashed passwords

users:
  jussi:
    shell: /bin/bash
    home: /home/jussi
    password: wontwork
    groups: secret

  markku:
    shell: /bin/bash
    home: /home/markku
    password: wontwork
    groups: secret
