/tmp/helloworld.txt:
  file.managed:
    - source: salt://hello/helloworld.txt
    - template: jinja
    - context:
      username: {{ pillar.get('username', "stranger") }}
