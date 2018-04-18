/tmp/hellojinja.txt:
  file.managed:
    - source: salt://jinja.hello/hellojinja.txt
    - template: jinja
    - context:
      filecontent: Hello world!
