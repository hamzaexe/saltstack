install_apache:
    pkg.installed:
{% if grains['os_family'] == 'Debian' %}
      - name: apache2
{% if grains['os_family'] == 'Redhat' %}
      - name: httpd
{% endif %}

make sure apache is running:
    service.running:
{% if grains['os_family'] == 'Debian' %}
      - name: apache2
{% elif grains['os_family'] == 'RedHat' %}
      - name: httpd
{% endif %}
      - enable: True
      - require:
          - pkg: install_apache
      - watch:
        - file: sync mod_status.conf
        - file: sync mod_status.load

sync mod_status.conf:
 file.managed:
 - name: /etc/apache2/mods-enabled/mod_status.conf
 - source: salt://mod_status.conf
 - user: root
 - group: root
 - mode: 600

sync mod_status.load:
 file.managed:
 - name: /etc/apache2/mods-enabled/mod_status.load
 - source: salt://mod_status.load
 - user: root
 - group: root
 - mode: 600

