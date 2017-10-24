# Opzionalmente fai un fork dei progetti "elastic-base" e "elastic-data"... e sostituisci i 2 path nei comandi che seguono
# I repo usati al momento sono: 
#    elastic-base: https://github.com/p-sforza/elasticsearch-core-2.4-centos
#    elastic-data: https://github.com/p-sforza/elasticsearch

# Crea gli oggetti in OpenShift
oc new-project myelastic
oc new-build https://github.com/p-sforza/elasticsearch-core-2.4-centos
# Aspetta che termini la build di base (circa 2 min.)

# Crea l'applicazione
oc new-app https://github.com/p-sforza/elasticsearch
oc expose service elasticsearch

# Opzionalmente configura i webhooks sui due imagestream per automatizzare il deployment

Test1: accesso alle risorse 
   http://elastic-myelastic.apps.justcodeon.it/ --> sulla / dell rotta elastic risponde elastic
   http://elastic-myelastic.apps.justcodeon.it/_plugin/head/ --> sul path _plugin/head/ è possibile vedere gli indici creati
   http://elastic.apps.justcodeon.it/earth_meteorite_landings_index/_search --> sul path earth_meteorite_landings_index/_search elastic ritorna i primi item indicizzati

Test2: update dei dati
   effettuare un update sul codice creando un nuovo indice:
   1) creazioen del nuovo json da caricare in data/
   2) aggiunta dell'entry nel file mapping/data.map (il formato è <DATA FILENAME> <INDEX NAME> <TYPE NAME> )
   

Issue note
1) 

Da implementare
1) mapping dei type sugli indici
2) kibana
3) template

NOTE:
# Per un run locale:
git clone https://github.com/p-sforza/elasticsearch-core-2.4-centos
git clone https://github.com/p-sforza/elasticsearch

cd [https://github.com/p-sforza/elasticsearch | elasticsearch]
docker build -t <IMAGE NAME>:<IMAGE VERSION> -f ./Dockerfile .
docker run <IMAGE NAME>:<IMAGE VERSION>
