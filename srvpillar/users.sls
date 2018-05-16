# Passwords are generated with `sudo salt '*' shadow.gen_password Password_goes_here`

users:
  jussi:
    uid: 1001
    shell: /bin/bash
    home: /home/jussi
    password: $6$YLcAaEph$xSmWUZVMmO4Ss4P1phqOUup4wVVarccLxymiif1WZq4xrr0WxutNZ1CzWa2xi64K7hx61MEUF$

  markku:
    uid: 1002
    shell: /bin/bash
    home: /home/markku
    password: $6$WDOJ97dq$2eOys3YuNFw34keS.WLl7l1s4DlNp2Ntr3YPTvueG0a.oHUEM5tihXDeXByykP6HD0ud80Ed8$
