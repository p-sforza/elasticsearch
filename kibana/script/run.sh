#!/usr/bin/env bash
#
# echo elasticsearch.url: http://172.17.0.2:9200 >> /opt/kibana/config/kibana.yml
# EXPOSE 5601
# /opt/kibana/bin/kibana

echo "NEW KIBANA START!";

echo "ENVIRONMENT:";
   env;
echo "END ENVIRONMENT";

KIBANA_PID=$(ps -aux | grep kibana | grep -v grep | awk '{ print $2 }');
ps -aux;
if [ $KIBANA_PID ]; then
        echo "ERROR: KIBANA IS ALREADY UP!";
        exit 1;
else 
        # CONFIGURE KIBANA
        echo "CONFIGURING KIBANA!";
        echo "elasticsearch.url: ${ELASTIC_URL}" >> /opt/kibana/config/kibana.yml ;

	# START KIBANA
	echo "STARTING KIBANA!"
	/opt/kibana/bin/kibana

	#echo "LOGFILE:";
        #cat ${ELASTIC_LOG};
        #echo "END OF LOGFILE";
 
	#STARTED=$(grep started $ELASTIC_LOG);
	#while [ "$STARTED" == "" ]; do
	#	echo '   elastic not up...';
	#	sleep 1;
	#	STARTED=$(grep started $ELASTIC_LOG);
	#done
	#echo "ELASTIC IS UP!"
	#echo "ELASTIC PROCESS: " && ps -aux | grep elastic | grep java | grep -v grep | awk '{ print $2 }' ;
        #echo "LOGFILE:";
        #   cat ${ELASTIC_LOG};
        #echo "END OF LOGFILE";

fi
#echo "SCRIPT END... BYE BYEi" 
