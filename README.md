# INTRO
Questo codice consente di creare una istanza di elasticsearch containerizzata che crea gli indici in fase di build a partire da:
1) i dati (.json) caricati in data/
2) i tipi (.type) caricati in type/ (DA IMPLEMENTARE)
3) il file di map (data.map) che contiene l'associazione  DATA_FILENAME INDEX_NAME TYPE_NAME

in script/ è presente il file insertdata.sh che viene lanciato in fase di build e lancia la procedura di bulk_upload.

Il container si basa su:
1) centos:7
2) elastic 2.4 (e il plugin mobz/elasticsearch-head che permette di navigare gli indici a scopo test)
3) java-1.8.0-openjdk
4) nodejs e es-json-load (per implementare il bulk_upload)

Inoltre:
1) Il Dokerfile presente in https://github.com/p-sforza/elasticsearch-core-2.4-centos implementa l'immagine base con le dipendenze e un test di run su elastic
2) Il Dokerfile presente in https://github.com/p-sforza/elasticsearch implementa il bulkupload 

# SETUP
## REPO BASE
Opzionalmente fai un fork dei progetti "elastic-base" e "elastic-data"... e sostituisci i 2 path nei comandi che seguono.

I repo usati al momento sono
1) elastic-base: https://github.com/p-sforza/elasticsearch-core-2.4-centos
2) elastic-data: https://github.com/p-sforza/elasticsearch

## OPENSHIFT
### Base image
```
oc new-project myelastic
oc new-build https://github.com/p-sforza/elasticsearch-core-2.4-centos
```
NOTE: Aspetta che termini la build di base (circa 2 min.).

### APP
```
oc new-app https://github.com/p-sforza/elasticsearch
oc expose service elasticsearch
```
NOTE: Opzionalmente configura i webhooks sui due imagestream per automatizzare il deployment.

## TEST
### Test1: accesso alle risorse 
   http://YOUR_APP_URL/
       --> sulla / dell rotta elastic risponde elastic

   http://YOUR_APP_URL/_plugin/head/ 
       --> sul path _plugin/head/ è possibile accedere al plugin installato, vedere e navigare gli indici creati

   http://YOUR_APP_URL/earth_meteorite_landings_index/_search 
       --> sul path earth_meteorite_landings_index/_search elastic ritorna i primi item indicizzati *

   *se cambi il nome dell'indice aggiusta il path

### Test2: update dei dati
   effettuare un update sul codice creando un nuovo indice:
   1) creazioen del nuovo json da caricare in data/
   2) aggiunta dell'entry nel file mapping/data.map (il formato è DATA_FILENAME INDEX_NAME> TYPE_NAME )
   

# Issue note
1) 

# Da implementare
1) mapping dei type sugli indici
2) kibana
3) merge dei due repo
4) template openshift
5) on/off mobz/elasticsearch-head da variabile d'ambiente
6) configurazioni in variabili d'ambiente

# NOTE:
Per un run locale:
```
git clone https://github.com/p-sforza/elasticsearch-core-2.4-centos
git clone https://github.com/p-sforza/elasticsearch

cd [https://github.com/p-sforza/elasticsearch | elasticsearch]
docker build -t IMAGE_NAME:IMAGE_VERSION -f ./Dockerfile .
docker run IMAGE_NAME:IMAGE_VERSION
```
