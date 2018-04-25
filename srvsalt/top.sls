base:
  '*':
    - hello

  'local*':
    - ssh
    - basicapps

  'srv*':
    - apache
    - vhost
