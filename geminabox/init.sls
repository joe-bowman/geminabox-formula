{% from "geminabox/map.jinja" import geminabox,geminabox_cfg,geminabox_init with context %}

geminabox_dependencies:
  pkg.installed:
    - pkgs: {{ geminabox.get('pkgs')|json }}

geminabox_gem:
  gem.installed:
    - name: {{ geminabox.get('geminabox_gem') }}
    {%- if geminabox.get('geminabox_gem_version', False) %}
    - version: {{ geminabox.get('geminabox_gem_version') }}
    {%- endif %}

geminabox_root:
  file.directory:
    - name: {{ geminabox.get('file_root') }}
    - makedirs: True

geminabox_logs:
  file.directory:
    - name: {{ geminabox.get('log_path') }}
    - makedirs: True

geminabox_data:
  file.directory:
    - name: {{ geminabox_cfg.get('data') }}
    - makedirs: True

geminabox_manage_config_ru:
  file.managed:
    - name: {{ geminabox.get('file_root') }}/config.ru
    - source: salt://geminabox/files/config.ru.jinja
    - template: jinja
    - context:
      config: {{ geminabox_cfg }}

geminabox_manage_init:
  file.managed:
    - name: {{ geminabox_init.get('file_path') }}
    - source: {{ geminabox_init.get('source') }}
    - template: jinja
    - mode: {{ geminabox_init.get('permissions') }}
    - context:
      geminabox: {{ geminabox }}

geminabox_service:
  service.running:
    - name: geminabox
    - enable: True
    - restart: True
    - require:
      - file: geminabox_manage_config_ru
      - file: geminabox_manage_init
    - watch:
      - file: geminabox_manage_config_ru
      - file: geminabox_manage_init
