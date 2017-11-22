#!/usr/bin/env bash
#

echo "NEW KIBANA START!";

echo "ENVIRONMENT:";
   env;
echo "END ENVIRONMENT";

KIBANA_PID=$(ps -aux | grep kibana | grep -v grep | awk '{ print $2 }');
if [ $KIBANA_PID ]; then
        echo "ERROR: KIBANA IS ALREADY UP!";
        exit 1;
else
       # WITH ENV VAR YOU CAN OVVERRIDE DEFAULT URL FOR ESHOT ELASTIC URL
       # docker run -e "ELASTICSEARCH_URL=http://aaa:1234" kibana:2.0
 
       if [ -n "$ELASTICSEARCH_URL" ]; then
		echo ELASTICSEARCH_URL WAS ALREADY SET TO: $ELASTICSEARCH_URL
		echo elasticsearch.url: ${ELASTICSEARCH_URL} >> /opt/kibana/config/kibana.yml
	else
		# SETTING TO DEFAULT
		echo ELASTICSEARCH_URL WAS EMPTY! SETTING TO DEFAULT...
		echo elasticsearch.url: http://eshot:9200 >> /opt/kibana/config/kibana.yml
	fi

	# START KIBANA
        echo "STARTING KIBANA!"
	/opt/kibana/bin/kibana
fi

echo "SCRIPT END... BYE BYE" 
