# Passwords need to be created separately for each client using
# sudo salt '*' shadow.gen_password Password_goes_here
# and added here in place of the non-working, non-hashed passwords

users:
  jussi:
    uid: 1001
    shell: /bin/bash
    home: /home/jussi
    password: wontwork
    groups: secret

  markku:
    uid: 1002
    shell: /bin/bash
    home: /home/markku
    password: wontwork
    groups: secret
