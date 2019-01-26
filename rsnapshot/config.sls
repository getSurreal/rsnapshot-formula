# vim: ft=sls
# How to configure rsnapshot
{%- from "rsnapshot/map.jinja" import rsnapshot with context %}

remove_default_config:
  file.absent:
    - name: /etc/rsnapshot.conf

rsnapshot_conf_directory:
  file.directory:
    - name: /etc/rsnapshot/conf.d
    - user: root
    - group: root
    - makedirs: True

{% for server in pillar['rsnapshot']['servers'].items()  %}
rsnapshot_{{ server }}_config:
  file.managed:
    - name: /etc/rsnapshot/conf.d/rsnapshot-{{ server }}.conf
    - source: salt://rsnapshot/files/rsnapshot.conf
    - user: root
    - group: root
    - mode: 0600
    - template: jinja
    - context: {{ server }}
{% endfor %}