# HPQC
Sviluppare degli script, che in base ad un file di configurazione, configurano il file system distribuito (esistono dei comandi). Gli esperimenti devono essere estendibili e replicabili ed eventualmente portabili sul cluster fisico.
Benchmark di Yarn in base alle configurazioni con workload DFSIO/Teragen, il benchmark sono lanciati in parallelo agli script di misura.
Il file system è virtualmente distribuito perché i vari componenti sono dei container.


## Table of Contents
1. [Apache Hadoop](doc/Hadoop.md)
    * [Introduction](doc/Hadoop.md#intro)
    * [HDFS](doc/Hadoop.md#hdfs)
    * [MapReduce](doc/Hadoop.md#mapred)
    * [YARN](doc/Hadoop.md#YARN)
1. [Cluster Configuration](doc/Parameters.md)
    * [HDFS](doc/Parameters.md#hdfsparanalysis)
    * [MapReduce](doc/Parameters.md#maprredparanalysis)
    * [YARN](doc/Parameters.md#yarnparanalysis)
1. [Environment Setup](doc/Setup.md)
    * [Tools](doc/Setup.md#tool)
        * [Java 1.8](doc/Setup.md#java1.8)
        * [Maven 3.6](doc/Setup.md#maven3.6)
        * [Hadoop 3.3.5](doc/Setup.md#hadoop3)
        * [Libraries](doc/Setup.md#l)
        * [SSH and PDSH](doc/Setup.md#ssh)
        * [Python Libraries](doc/Setup.md#pl)
    * [Building Hadoop](doc/Setup.md#build)
    * [Setting up Hadoop Cluster](doc/Setup.md#cluster)
1. [Test Cases Script](doc/Experiments.md)
    * [How the Script works](doc/Experiments.md#scriptwork)
    * [How to run the Script](doc/Experiments.md#scriptrun)
1. [Troubleshooting](doc/Troubleshooting.md)
1. [References](doc/References.md)
    * [Further References](doc/References.md#fref)


# Script
1. Definire la lista test da eseguire in termini di parametri in un file di configurazione (test_list.csv):
    1.1. Scegli uno o più parametri di configurazione per due/tre dei sottosistemi principali di Hadoop (tra YARN, MapReduce, NameNode, DataNode).
    1.2. Scegli i parametri e valori della suite di benchmark, e.g. una tra DFSIO, Terasort, nnbench, etc. (-read/write, -nrFiles, –fileSize, etc).
    1.3. In generale, non esagerare nè con i parametri, nè con i livelli degli stessi. Per questa PoC, limitiamoci a valori binari, e.g. yarn.scheduler.maximum-allocation-vcores={4,8}.
    1.4. Nota che non ci interessano tutte le combinazioni di valori ed interazioni tra parametri (e.g. full-factorial design). L'importante è poter aggiungere una nuova riga o modificare un parametro e poter subito lanciare la nuova lista di test senza modificare null'altro che il primo file test_list.csv.
2. Da script (run_test.sh/py), per ogni riga del file test_list.csv:
    2.1. Configurare il sistema:
        2.1.1. Configurare Hadoop, modificando i parametri nei vari file *-site.xml e/o da linea di comando (come ti risulti più convenieninte). NB: assicurati che le modifiche abbiano effetto sul sistema, dato che per alcune potrebbe essere necessario riavviare yarn o tutto il DFS.
        2.1.2. Configurare la suite di benchmark (semplicemente settando delle variabili che poi andrai ad utilizzare nella chiamata alla suite).
    3.1. Eseguire il test chiamando la suite di benchmark.
    3.2. Raccogliere i valori delle variabili di risposta in una riga di un file CSV (test_result.csv).









