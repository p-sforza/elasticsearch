FROM registry.centos.org/centos/centos:7
ADD elasticsearch-2.4.0.rpm  earth_meteorite_landings.json /

RUN ["/bin/bash", "-c", "yum -y install epel-release && \
                         yum -y update && \
                         yum -y install java-1.8.0-openjdk nss_wrapper gettext && \
                         yum -y install /elasticsearch-2.4.0.rpm && \
                         ln -s /etc/elasticsearch/ /usr/share/elasticsearch/config && \
                         ln -s /var/log/elasticsearch/ /usr/share/elasticsearch/logs && \
                         chown -R elasticsearch:elasticsearch /usr/share/elasticsearch/ && \
                         mkdir /home/elasticsearch && \
                         chown -R elasticsearch:elasticsearch /home/elasticsearch/ && \

                         chown -R elasticsearch:elasticsearch /etc/elasticsearch/ && \
                         echo network.host: 0.0.0.0 >>  /usr/share/elasticsearch/config/elasticsearch.yml && \
                         /usr/share/elasticsearch/bin/plugin install mobz/elasticsearch-head && \

                         yum install -y nodejs npm net-tools && \
                         npm install es-json-load -g && \
                         chsh -s /bin/bash elasticsearch"]


#RUN ["/bin/bash", "-c", "touch /run.sh"]
RUN echo '#!/usr/bin/env bash' > /run.sh
RUN ["/bin/bash", "-c", "echo \"runuser -l elasticsearch -c '/usr/share/elasticsearch/bin/elasticsearch -d'\" >> /run.sh"]
RUN ["/bin/bash", "-c", "echo \"runuser -l elasticsearch -c '/usr/share/elasticsearch/bin/elasticsearch -d'\" >> /run.sh"]
RUN ["/bin/bash", "-c", "echo \"sleep 15\" >> /run.sh"]
RUN ["/bin/bash", "-c", "echo \"chown elasticsearch:elasticsearch /earth_meteorite_landings.json\" >> /run.sh"]
RUN ["/bin/bash", "-c", "echo \"netstat -anp | grep elastic\" >> /run.sh"]
RUN ["/bin/bash", "-c", "echo \"es-json-load --data --file=/earth_meteorite_landings.json --index=testk --type=tipek\" >> /run.sh"]
                        
RUN ["/bin/bash", "-c", "chmod +x /run.sh && \
                        /run.sh"]

USER elasticsearch
EXPOSE 9200 9300
ENTRYPOINT ["/usr/share/elasticsearch/bin/elasticsearch"]

