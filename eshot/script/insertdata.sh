#!/usr/bin/env bash
echo "ENVIRONMENT:";
   env;
echo "END ENVIRONMENT";

echo "NEW BUILD FOR ELASTIC!" > "${ELASTIC_LOG}";

ELASTIC_PID=$(ps -aux | grep elastic | grep java | grep -v grep | awk '{ print $2 }');
ps -aux;
if [ $ELASTIC_PID ]; then
        echo "ERROR: ELASTIC IS ALREADY UP!" 
        exit 1;
else 
	# START ELASTIC
	echo "STARTING ELASTIC!";
	/usr/share/elasticsearch/bin/elasticsearch -d;

	echo "LOGFILE:";
        cat ${ELASTIC_LOG};
        echo "END OF LOGFILE";
 
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

	# UPLOAD DATA
	echo "STARTING DATA UPLOAD!" >> "${ELASTIC_LOG}" ;

	mapfile -t INDEX_MAP < "${HOME}/mapping/data.map"   
	for LINE in "${INDEX_MAP[@]}"; do
		IFS=' ' read -ra I <<< "$LINE"
                echo "MAP: $LINE";
		echo "DATA: ${I[0]}";
                echo "INDEX: ${I[1]}";
		echo "TYPE: ${I[2]}";

	        es-json-load --data --file=${HOME}/data/${I[0]} --index=${I[1]} --type=${I[2]};
                
		echo "LOGFILE:";
                   cat ${ELASTIC_LOG};
                echo "END OF LOGFILE";
	done
	
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

