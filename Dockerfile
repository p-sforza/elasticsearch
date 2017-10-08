FROM registry.centos.org/centos/centos:7
ADD elasticsearch-2.4.0.rpm  earth_meteorite_landings.json insertdata.sh /

RUN ["/bin/bash", "-c", "yum -y install epel-release"]
RUN ["/bin/bash", "-c", "yum -y update"]
RUN ["/bin/bash", "-c", "yum -y install java-1.8.0-openjdk nss_wrapper gettext"]
RUN ["/bin/bash", "-c", "yum -y install /elasticsearch-2.4.0.rpm"]
RUN ["/bin/bash", "-c", "ln -s /etc/elasticsearch/ /usr/share/elasticsearch/config"]
RUN ["/bin/bash", "-c", "ln -s /var/log/elasticsearch/ /usr/share/elasticsearch/logs"]
RUN ["/bin/bash", "-c", "chown -R elasticsearch:elasticsearch /usr/share/elasticsearch/"]
RUN ["/bin/bash", "-c", "mkdir /home/elasticsearch"]
RUN ["/bin/bash", "-c", "chown -R elasticsearch:elasticsearch /home/elasticsearch/"]
RUN ["/bin/bash", "-c", "chown -R elasticsearch:elasticsearch /etc/elasticsearch/"]
RUN ["/bin/bash", "-c", "echo network.host: 0.0.0.0 >>  /usr/share/elasticsearch/config/elasticsearch.yml"]
RUN ["/bin/bash", "-c", "/usr/share/elasticsearch/bin/plugin install mobz/elasticsearch-head"]
RUN ["/bin/bash", "-c", "yum install -y nodejs npm net-tools"]
RUN ["/bin/bash", "-c", "npm install es-json-load -g"]
RUN ["/bin/bash", "-c", "chsh -s /bin/bash elasticsearch"]


#RUN ["/bin/bash", "-c", "touch /run.sh"]
#RUN echo '#!/usr/bin/env bash' > /run.sh
#RUN ["/bin/bash", "-c", "echo \"runuser -l elasticsearch -c '/usr/share/elasticsearch/bin/elasticsearch -d'\" >> /run.sh"]
#RUN ["/bin/bash", "-c", "echo \"runuser -l elasticsearch -c '/usr/share/elasticsearch/bin/elasticsearch -d'\" >> /run.sh"]
#RUN ["/bin/bash", "-c", "echo \"sleep 15\" >> /run.sh"]
#RUN ["/bin/bash", "-c", "echo \"chown elasticsearch:elasticsearch /earth_meteorite_landings.json\" >> /run.sh"]
#RUN ["/bin/bash", "-c", "echo \"netstat -anp | grep elastic\" >> /run.sh"]
#RUN ["/bin/bash", "-c", "echo \"es-json-load --data --file=/earth_meteorite_landings.json --index=testk --type=tipek\" >> /run.sh"]
                        
RUN ["/bin/bash", "-c", "chmod +x /insertdata.sh"]
RUN ["/bin/bash", "-c", "/insertdata.sh"]

USER elasticsearch
EXPOSE 9200 9300
ENTRYPOINT ["/usr/share/elasticsearch/bin/elasticsearch"]

