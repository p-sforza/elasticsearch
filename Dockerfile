FROM elastic/elasticsearch-core-24-centos
ADD earth_meteorite_landings.json insertdata.sh /

RUN ["/bin/bash", "-c", "chmod +x /insertdata.sh"]
RUN ["/bin/bash", "-c", "/insertdata.sh"]

USER elasticsearch
EXPOSE 9200 9300
ENTRYPOINT ["/usr/share/elasticsearch/bin/elasticsearch"]

