#!/usr/bin/env bash

#runuser -l elasticsearch -c '/usr/share/elasticsearch/bin/elasticsearch -d'

/bin/bash -c "/usr/share/elasticsearch/bin/elasticsearch -d"

sleep 15
chown elasticsearch:elasticsearch /earth_meteorite_landings.json

es-json-load --data --file=/earth_meteorite_landings.json --index=testk --type=tipek;
#sleep 1500000;
ps -aux;
PID=$(ps -aux | grep -m1 elastic | awk '{ print $2 }') && kill $PID;

