/tmp/helloworld.txt:
  file.managed:
    - source: salt://hello/helloworld.txt
    - template: jinja
    - makedirs: True
    - context:
      username: {{ pillar.get('username', "stranger") }}
