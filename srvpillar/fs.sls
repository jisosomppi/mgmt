users:
  jussi:
    uid: 1001
    shell: /bin/bash
    home: /home/jussi
    groups:
      - secret

  markku:
    uid: 1002
    shell: /bin/bash
    home: /home/markku
    groups:
      - secret
      
groups:
  secret:
    gid: 1337
