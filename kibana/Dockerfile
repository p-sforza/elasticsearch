FROM centos:7

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

# PREPARE
RUN ["/bin/bash", "-c", "mkdir -p ${HOME} && ls -lai ${HOME}"]
ADD kibana-4.6.6-x86_64.rpm ${HOME}

# INSTALL KIBANA DEPENDENCIES
RUN ["/bin/bash", "-c", "yum -y install epel-release"]
RUN ["/bin/bash", "-c", "yum -y install java-1.8.0-openjdk nss_wrapper gettext"]

# INSTALL, CONFIGURE AND RUN KIBANA
RUN ["/bin/bash", "-c", "yum -y install ${HOME}/kibana-4.6.6-x86_64.rpm && \
                         rm -f ${HOME}/kibana-4.6.6-x86_64.rpm"]

RUN ["/bin/bash", "-c", "chsh -s /bin/bash kibana && \
                         mkdir /home/kibana/ && \
                         echo \"kibana:password\"|chpasswd && \
                         usermod -u 10001 kibana && \
                         usermod -g 0 kibana"]

ADD script ${HOME}/script
RUN ["/bin/bash", "-c", "cp ${HOME}/script/run.sh /home/kibana && \
                         chown -R kibana /home/kibana && \
                            chgrp -R 0 /home/kibana && \
                            chmod -R g=u /home/kibana && \
                         chown -R kibana ${HOME} && \
                            chgrp -R 0 ${HOME} && \
                            chmod -R g=u ${HOME} && \                         
                         chown -R kibana /opt/kibana && \
                            chgrp -R 0 /opt/kibana && \
                            chmod -R g=u /opt/kibana && \
                         chmod +x ${HOME}/script/run.sh && \
                         cp ${HOME}/script/run.sh /home/kibana"]

USER kibana
EXPOSE 5601

CMD ["/home/kibana/run.sh"]
