#!/usr/bin/env bash
#

ELASTIC_LOG=/usr/share/elasticsearch/logs/elasticsearch.log
runuser -l elasticsearch -c 'echo "" > $ELASTIC_LOG';

ELASTIC_PID=$(ps -aux | grep elastic | grep java | grep -v grep | awk '{ print $2 }');
if [ $ELASTIC_PID ]; then
	echo "ERROR: ELASTIC IS ALREADY UP!" 
	exit 1;
else
	# START ELASTIC
        echo "STARTING ELASTIC!";
        /usr/share/elasticsearch/bin/elasticsearch -d;
	STARTED=$(grep started $ELASTIC_LOG);
        while [ "$STARTED" == "" ]; do
                echo '   elastic not up...';
                sleep 1;
                STARTED=$(grep started $ELASTIC_LOG);
        done
	echo "ELASTIC IS UP!" 
	echo "ELASTIC PROCESS: " && ps -aux | grep elastic | grep java | grep -v grep | awk '{ print $2 }' ;
	echo "LOGFILE:";
           cat ${ELASTIC_LOG};
	echo "END OF LOGFILE";

	# STOP ELASTIC
        echo "SHUTTING DOWN ELASTIC!" && echo "SHUTTING DOWN ELASTIC!" >> "${ELASTIC_LOG}" ;

        ps -aux
        ELASTIC_PID=$(ps -aux | grep elastic | grep java | grep -v grep | awk '{ print $2 }')
        kill ${ELASTIC_PID};

        STOPPED=$(grep " closed" ${ELASTIC_LOG});
        while [ "$STOPPED" == ""  ]; do
                echo '   elastic not down...';
                sleep 1;
                STOPPED=$(grep closed ${ELASTIC_LOG});
        done
        echo "ELASTIC IS DOWN!" 
fi

echo "SCRIPT END... BYE BYE" 

