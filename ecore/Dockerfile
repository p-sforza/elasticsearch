FROM registry.centos.org/centos/centos:7

MAINTAINER Pierluigi Sforza <psforza@redhat.com>

ENV \
       SUMMARY="Base image for elastic 2.4 and utils"      \ 
       DESCRIPTION="This image provide elastic core and some utils: plugin head to browse indexes; es-json-load bulk uploader in nodejs" \
       HOME=/opt/app-root/src/ \
       ELASTIC_HOME=/usr/share/elasticsearch \
       ELASTIC_LOG="/usr/share/elasticsearch/logs/elasticsearch.log" \
       JAVA_VER=1.8.0 \
       ES_VER=2.4.0 \
       ES_CONF=/usr/share/elasticsearch/config/ \
       INSTANCE_RAM=512G \
       NODE_QUORUM=1 \
       RECOVER_AFTER_NODES=1 \
       RECOVER_EXPECTED_NODES=1 \
       RECOVER_AFTER_TIME=5m \
       PLUGIN_LOGLEVEL=INFO \
       ES_JAVA_OPTS="-Dmapper.allow_dots_in_name=true"
 
LABEL \
       summary="$SUMMARY" \
       description="$DESCRIPTION" \
       io.k8s.description="$DESCRIPTION" \
       io.k8s.display-name="elasticsearch ${ES_VER} core" \
       io.openshift.expose-services="9200:https, 9300:https" \
       name="elasticsearch-core-2.4-centos" \
       version="1" \
       release="1"

RUN ["/bin/bash", "-c", "mkdir -p ${HOME} && ls -lai ${HOME}"]
ADD elasticsearch-2.4.0.rpm ${HOME}
ADD run.sh ${HOME}

# INSTALL ELASTIC DEPENDENCIES
RUN ["/bin/bash", "-c", "yum -y install epel-release"]
RUN ["/bin/bash", "-c", "yum -y install java-1.8.0-openjdk nss_wrapper gettext"]

# INSTALL, CONFIGURE AND RUN ELASTIC FOR TEST
RUN ["/bin/bash", "-c", "yum -y install ${HOME}/elasticsearch-2.4.0.rpm && rm -f ${HOME}/elasticsearch-2.4.0.rpm"]

RUN ["/bin/bash", "-c", "ln -s /etc/elasticsearch/ /usr/share/elasticsearch/config"]
RUN ["/bin/bash", "-c", "ln -s /var/log/elasticsearch/ /usr/share/elasticsearch/logs"]
RUN ["/bin/bash", "-c", "chown -R elasticsearch:elasticsearch /usr/share/elasticsearch/"]

RUN ["/bin/bash", "-c", "mkdir /home/elasticsearch"]
RUN ["/bin/bash", "-c", "chsh -s /bin/bash elasticsearch"]
RUN ["/bin/bash", "-c", "echo ELASTIC_LOG = $ELASTIC_LOG >> /home/elasticsearch/.bash_proflle"]
RUN ["/bin/bash", "-c", "chown -R elasticsearch:elasticsearch /home/elasticsearch/"]
RUN ["/bin/bash", "-c", "chown -R elasticsearch:elasticsearch /etc/elasticsearch/"]
RUN ["/bin/bash", "-c", "echo network.host: 0.0.0.0 >>  /usr/share/elasticsearch/config/elasticsearch.yml"]
RUN ["/bin/bash", "-c", "/usr/share/elasticsearch/bin/plugin install mobz/elasticsearch-head"]
  
RUN ["/bin/bash", "-c", "chmod +x ${HOME}/run.sh && su elasticsearch --preserve-environment ${HOME}/run.sh && rm -f ${HOME}/run.sh"]

# INSTALL BULK UPLOADER
RUN ["/bin/bash", "-c", "yum install -y nodejs npm net-tools"]
RUN ["/bin/bash", "-c", "npm install es-json-load -g"]
