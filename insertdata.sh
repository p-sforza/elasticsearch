#!/usr/bin/env bash

runuser -l elasticsearch -c '/usr/share/elasticsearch/bin/elasticsearch -d'
sleep 15
chown elasticsearch:elasticsearch /earth_meteorite_landings.json
netstat -anp | grep elastic

es-json-load --data --file=/earth_meteorite_landings.json --index=testk --type=tipek;
sleep 15;


