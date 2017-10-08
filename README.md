git clone ....
cd ...
docker build -t myelastic:1.1 -f ./Dockerfile .
docker run myelastic:1.1

oc new-build https://github.com/p-sforza/elasticsearch
oc new-app --docker-image=elasticsearch --name=elastic
oc expose service elastic

http://<hostname>[:9200]/_plugin/head/
