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
  - java

logstash:
  user.present:
    - home: /mnt/logstash
    - shell: /bin/nologin
    - system: True
    - gid_from_name: True
    - require:
      - group: logstash
  group.present:
    - system: True

/mnt/logstash/logstash.jar:
  file.managed:
    - source: http://logstash.objects.dreamhost.com/release/logstash-1.1.9-monolithic.jar
    - user: logstash
    - group: logstash
    - require:
      - user: logstash
      - group: logstash
      - pkg: java

/var/log/logstash:
  file.directory:
    - user: logstash
    - group: logstash
    - require:
      - user: logstash
      - group: logstash

/etc/logstash:
  file.directory:
    - user: logstash
    - group: logstash
    - require:
      - user: logstash
      - group: logstash
