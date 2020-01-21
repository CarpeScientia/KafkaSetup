#!/bin/bash

echo "parameters: $1 $2 $3 $4 $5"
if [ -z "$1" ]
then
        printf "parameters are:
TOPIC (name of the kafka topic)\n"
        echo ""
        exit 1
fi
export TOPIC=$1

sudo apt-get install openjdk-11-jdk -y

wget http://apache.cs.uu.nl/kafka/2.3.0/kafka_2.12-2.3.0.tgz


read -p "Press [Enter] key"

tar -xzf kafka_2.12-2.3.0.tgz
cd kafka_2.12-2.3.0
echo 'ZooKeeper start'
bin/zookeeper-server-start.sh -daemon config/zookeeper.properties 

read -p "Press [Enter] key"
echo 'Kafka start'
bin/kafka-server-start.sh -daemon config/server.properties

read -p "Press [Enter] key"
echo 'register topic'
bin/kafka-topics.sh --create --bootstrap-server localhost:9092 --replication-factor 1 --partitions 1 --topic $TOPIC


read -p "Press [Enter] key"
echo 'list topics'
bin/kafka-topics.sh --list --bootstrap-server localhost:9092
