#!/bin/bash

# Stop HDFS deamons,YARN deamons and JobHistoryServer
$HADOOP_HOME/sbin/stop-dfs.sh                      
$HADOOP_HOME/sbin/stop-yarn.sh
$HADOOP_HOME/bin/mapred --daemon stop historyserver


#rm -rf ./tmp/hadoop-${user}/dfs/data/*

# Format the filesystem
#$HADOOP_HOME/bin/hdfs namenode -format             

# Start HDFS deamons,YARN deamons and JobHistoryServer
$HADOOP_HOME/sbin/start-dfs.sh                     
$HADOOP_HOME/bin/hdfs dfsadmin -safemode leave                # Forcefully let the namenode leave safemode
$HADOOP_HOME/sbin/start-yarn.sh
$HADOOP_HOME/bin/mapred --daemon start historyserver

# Make the HDFS directories required to execute MapReduce jobs
$HADOOP_HOME/bin/hdfs dfs -mkdir /user             
$HADOOP_HOME/bin/hdfs dfs -mkdir /user/$(whoami)

# Copy the input files into the distributed filesystem
$HADOOP_HOME/bin/hdfs dfs -mkdir input
$HADOOP_HOME/bin/hdfs dfs -put $HADOOP_HOME/etc/hadoop/*.xml input