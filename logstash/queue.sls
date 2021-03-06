# Copyright 2012-2013 Hewlett-Packard Development Company, L.P.
# All Rights Reserved.
#
#    Licensed under the Apache License, Version 2.0 (the "License"); you may
#    not use this file except in compliance with the License. You may obtain
#    a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#    License for the specific language governing permissions and limitations
#    under the License.
#
include:
  - logstash

/etc/init/logstash-queue.conf:
  file.managed:
    - source: salt://logstash/queue.init
    - user: root
    - group: root

/etc/logstash/queue.conf:
  file.managed:
    - source: salt://logstash/queue.conf
    - template: jinja
    - user: logstash
    - group: logstash
    - require:
      - file: /etc/logstash

{{ pillar['lumberjack']['cert'] }}:
  file.managed:
    - user: logstash
    - contents: |
        {{ pillar['lumberjack']['cert_contents'] | indent(8) }}

{{ pillar['lumberjack']['key'] }}:
  file.managed:
    - user: logstash
    - contents: |
        {{ pillar['lumberjack']['key_contents'] | indent(8) }}

logstash-queue:
  service.running:
    - require:
      - file: /etc/init/logstash-queue.conf
      - file: /etc/logstash/queue.conf
      - file: /var/log/logstash
      - file: /etc/ssl/certs/logstash.crt
      - file: /etc/ssl/private/logstash.key
    - watch:
      - file: /etc/logstash/queue.conf
      - file: /etc/init/logstash-queue.conf
      - service: redis-server

