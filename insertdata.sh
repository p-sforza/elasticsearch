#!/usr/bin/env bash
env

touch ${ELASTIC_LOG} && ls -lai /usr/share/elasticsearch/logs/;
echo "NEW BUILD FOR ELASTIC!" > "${ELASTIC_LOG}";

ELASTIC_PID=$(ps -aux | grep -m1 elastic | grep -v grep | awk '{ print $2 }');
ps -aux;
if [ $ELASTIC_PID ]; then
        echo "ERROR: ELASTIC IS ALREADY UP!" 
        exit 1;
else 
	# START ELASTIC
	echo "STARTING ELASTIC!";
	/usr/share/elasticsearch/bin/elasticsearch -d;

	until [ STARTED=$(grep started "${ELASTIC_LOG}" ) ]; do
		echo '   elastic not up...';
		sleep 1;
	done
	echo "ELASTIC IS UP!"
	echo "ELASTIC PROCESS: " && ps -aux | grep -m1 elastic;

	# UPLOAD DATA
	echo "STARTING DATA UPLOAD!" >> "${ELASTIC_LOG}" ;
	chown elasticsearch:elasticsearch /earth_meteorite_landings.json
	es-json-load --data --file=/earth_meteorite_landings.json --index=testk --type=tipek;
	
	# STOP ELASTIC
	echo "SHUTTING DOWN ELASTIC!" && echo "SHUTTING DOWN ELASTIC!" >> "{$ELASTIC_LOG}" ;
	ELASTIC_PID=$(ps -aux | grep -m1 elastic | grep -v grep | awk '{ print $2 }')
	kill $ELASTIC_PID;
	
	until [ STOPPED=$(grep closed "${ELASTIC_LOG}" ) ]; do
		echo '   elastic not down...';
		sleep 1;
	done
        echo "ELASTIC IS DOWN!" 
fi

echo "SCRIPT END... BYE BYE" 

