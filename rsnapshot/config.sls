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

rsnapshot_log_directory:
  file.directory:
    - name: /var/log/rsnapshot
    - user: root
    - group: root
    - makedirs: True

rsnapshot_snapshot_directory:
  file.directory:
    - name: {{ pillar['rsnapshot']['config']['snapshot_root'] }}
    - user: root
    - group: root
    - makedirs: True

{% for server,args in pillar['rsnapshot']['servers'].items()  %}
rsnapshot_{{ server }}_config:
  file.managed:
    - name: /etc/rsnapshot/conf.d/rsnapshot-{{ server }}.conf
    - source: salt://rsnapshot/files/rsnapshot.conf
    - user: root
    - group: root
    - mode: 0600
    - template: jinja
    - config: {{ pillar['rsnapshot']['config'] }}
    - server: {{ server }}

{% for job,cron in pillar['rsnapshot']['servers'][server]['cron'].items()  %}
rsnapshot_{{ server }}_{{ job }}_cron:
{% if cron.enabled | default(False)  %}
  cron.present:
    - name: /usr/bin/rsnapshot -c /etc/rsnapshot/conf.d/rsnapshot-{{ server }}.conf {{ job }}
    - minute: u'{{ cron.minute }}'
    - hour: u'{{ cron.hour }}'
    - daymonth: u'{{ cron.daymonth }}'
    - month: u'{{ cron.month }}'
    - dayweek: u'{{ cron.dayweek }}'
{% else %}
  cron.absent:
    - name: /usr/bin/rsnapshot -c /etc/rsnapshot/conf.d/rsnapshot-{{ server }}.conf {{ job }}
{% endif %}
{% endfor %}
{% endfor %}
