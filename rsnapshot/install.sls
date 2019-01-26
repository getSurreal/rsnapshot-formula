# vim: ft=sls
# How to install rsnapshot
{%- from "rsnapshot/map.jinja" import rsnapshot with context %}

rsnapshot_pkg:
  pkg.installed:
    - name: {{ rsnapshot.pkg }}

