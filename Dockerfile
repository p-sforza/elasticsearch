FROM elastic/elasticsearch-core-24-centos

ENV \
      SUMMARY="Image to create index for elastic 2.4 in build phase" \
      DESCRIPTION="This image provide elastic core with data on repo" \
      ELASTIC_LOG='/usr/share/elasticsearch/logs/elasticsearch.log'


LABEL summary="$SUMMARY" \
      description="$DESCRIPTION" \
      io.k8s.description="$DESCRIPTION" \
      io.k8s.display-name="elasticsearch" \
      name="elasticsearch" \
      version="1" \
      release="1.0"


ADD earth_meteorite_landings.json insertdata.sh /

RUN ["/bin/bash", "-c", "chmod +x /insertdata.sh"]
RUN ["/bin/bash", "-c", "/insertdata.sh"]

USER elasticsearch
EXPOSE 9200 9300
ENTRYPOINT ["/usr/share/elasticsearch/bin/elasticsearch"]

