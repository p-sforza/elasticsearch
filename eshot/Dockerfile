#FROM elasticsearch-core-24-centos:latest
FROM ecore:latest

ENV \
       SUMMARY="Image to create index for elastic 2.4 in build phase" \
       DESCRIPTION="This image provide elastic core with data on repo" \
       ELASTIC_LOG='/usr/share/elasticsearch/logs/elasticsearch.log' \
       HOME=/opt/app-root/src \
       ELASTIC_HOME=/usr/share/elasticsearch \
       JAVA_VER=1.8.0 \
       ES_CONF=/usr/share/elasticsearch/config/ \
       INSTANCE_RAM=512G \
       NODE_QUORUM=1 \
       RECOVER_AFTER_NODES=1 \
       RECOVER_EXPECTED_NODES=1 \
       RECOVER_AFTER_TIME=5m \
       PLUGIN_LOGLEVEL=INFO \
       ES_JAVA_OPTS="-Dmapper.allow_dots_in_name=true"

LABEL summary="$SUMMARY" \
      description="$DESCRIPTION" \
      io.k8s.description="$DESCRIPTION" \
      io.k8s.display-name="elasticsearch" \
      name="elasticsearch" \
      version="1" \
      release="1.0"


ADD data ${HOME}/data
ADD mapping ${HOME}/mapping
ADD script ${HOME}/script
ADD type ${HOME}/type

RUN ["/bin/bash", "-c", "chown -R elasticsearch /var/log/elasticsearch/ && \
                         chgrp -R 0 /var/log/elasticsearch/ && \
                         chmod -R g=u /var/log/elasticsearch/"]

RUN ["/bin/bash", "-c", "chown -R elasticsearch /usr/share/elasticsearch/ && \
                         chgrp -R 0 /usr/share/elasticsearch/ && \
                         chmod -R g=u /usr/share/elasticsearch/"]

RUN ["/bin/bash", "-c", "chown -R elasticsearch /etc/elasticsearch/ && \
                         chgrp -R 0 /etc/elasticsearch/ && \
                         chmod -R g=u /etc/elasticsearch/"]

RUN ["/bin/bash", "-c", "chown -R elasticsearch /home/elasticsearch/ && \
                         chgrp -R 0 /home/elasticsearch/ && \
                         chmod -R g=u /home/elasticsearch/"]

RUN ["/bin/bash", "-c", "chown -R elasticsearch ${HOME} && ls -lai ${HOME}"]
RUN ["/bin/bash", "-c", "chmod +x ${HOME}/script/insertdata.sh && ls -lai ${HOME}/script"]
RUN ["/bin/bash", "-c", "su elasticsearch --preserve-environment ${HOME}/script/insertdata.sh "]

USER elasticsearch
EXPOSE 9200 9300
ENTRYPOINT ["/usr/share/elasticsearch/bin/elasticsearch"]

