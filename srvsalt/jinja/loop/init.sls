{% for testfile in ['testone.txt', 'testtwo.txt', 'testthree.txt'] %}

/tmp/loop/{{ testfile }}:
  file.managed:
    - source: salt://jinjaloop/loopbase.txt
    - makedirs: True
    - template: jinja
    - context:
      file: {{ testfile }}

{% endfor %}
