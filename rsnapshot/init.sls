# vim: ft=sls
# Init rsnapshot
{%- from "rsnapshot/map.jinja" import rsnapshot with context %}

{% if rsnapshot.enabled %}
include:
  - rsnapshot.install
  - rsnapshot.config
{% else %}
'rsnapshot-formula disabled':
  test.succeed_without_changes
{% endif %}

