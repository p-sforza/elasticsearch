FROM registry.centos.org/centos/centos:7

MAINTAINER Pierluigi Sforza <psforza@redhat.com>

ENV \
       SUMMARY="Base image for kibana"      \ 
       DESCRIPTION="This image provide kibana core" \
       HOME=/opt/app-root/src/ \
       #KIBANA_HOME=/usr/share/... \
       #KIBANA_LOG="/usr/share/..." \
       JAVA_VER=1.8.0 \
       KIBANA_VER=4.6.x \
       #KIBANA_CONF=/usr/share/... \
       INSTANCE_RAM=512G \
       ES_JAVA_OPTS="-Dmapper.allow_dots_in_name=true"
 
LABEL \
       summary="$SUMMARY" \
       description="$DESCRIPTION" \
       io.k8s.description="$DESCRIPTION" \
       io.k8s.display-name="kibana ${ES_VER} core" \
       io.openshift.expose-services="5601:https" \
       name="kibana" \
       version="1" \
       release="1"


RUN ["/bin/bash", "-c", "mkdir -p ${HOME} && ls -lai ${HOME}"]
ADD kibana-4.6.6-x86_64.rpm ${HOME}

# INSTALL KIBANA DEPENDENCIES
RUN ["/bin/bash", "-c", "yum -y install epel-release"]
RUN ["/bin/bash", "-c", "yum -y install java-1.8.0-openjdk nss_wrapper gettext"]

# INSTALL, CONFIGURE AND RUN KIBANA
RUN ["/bin/bash", "-c", "yum -y install ${HOME}/kibana-4.6.6-x86_64.rpm && rm -f ${HOME}/kibana-4.6.6-x86_64.rpm"]
RUN ["/bin/bash", "-c", "echo elasticsearch.url: http://172.17.0.2:9200 >> /opt/kibana/config/kibana.yml "]


EXPOSE 5601
ENTRYPOINT ["/opt/kibana/bin/kibana"]

