/tmp/hellojinja.txt:
  file.managed:
    - source: salt://hellojinja/hellojinja.txt
    - template: jinja
    - context:
      filecontent: Hello world!
