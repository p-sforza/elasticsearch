FROM elastic/elasticsearch-core-24-centos

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


ADD data ${HOME}
ADD mapping ${HOME}
ADD script ${HOME}
ADD type ${HOME}

RUN ["/bin/bash", "-c", "chown -R elasticsearch:elasticsearch ${HOME}"]
RUN ["/bin/bash", "-c", "chmod +x ${HOME}/script/insertdata.sh"]
RUN ["/bin/bash", "-c", "su elasticsearch --preserve-environment /insertdata.sh"]

USER elasticsearch
EXPOSE 9200 9300
ENTRYPOINT ["/usr/share/elasticsearch/bin/elasticsearch"]

