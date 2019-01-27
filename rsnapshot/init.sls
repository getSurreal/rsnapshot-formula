# vim: ft=sls
# Init rsnapshot
{%- from "rsnapshot/map.jinja" import rsnapshot with context %}

include:
  - rsnapshot.install
  - rsnapshot.config

