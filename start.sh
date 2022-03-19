#!/bin/bash

NMC_VERSION=2.0

if [ -z $BTC_PAYMENT_ADDRESS ]; then 
  echo
  echo ">>> No BTC_PAYMENT_ADDRESS specified, mining for the container author..."  
  BTC_PAYMENT_ADDRESS=3GeeWcjw3uYhYFD8V9Jhj6a5ApSgRvUG9z
fi 

LOCATION=$(printf 'eu-north\neu-west\nusa-west\nusa-east\n' | shuf -n1)


[ -z $BTC_THREADS ] && BTC_THREADS=$(nproc)
[ -z $BTC_WORKER_ID ] && BTC_WORKER_ID=`hostname`
[ -z $BTC_SERVER ] && BTC_SERVER=equihash.$LOCATION.nicehash.com:3357

echo
echo "****************************************************"
echo "NiceHash Container Mining Agent"
echo "****************************************************"
echo "Version: ${NMC_VERSION}"
echo "Address: ${BTC_PAYMENT_ADDRESS}"
echo "Server: ${BTC_SERVER}"
echo "WorkerID: ${BTC_WORKER_ID}"
echo "****************************************************"
echo "Threads: ${BTC_THREADS}"
echo
echo "Compiling for current host processor..."
cd /root/nheqminer/cpu_xenoncat/Linux/asm/
sh assemble.sh 
cd ../../../Linux_cmake/nheqminer_cpu 
cmake . 
make

echo
echo "****************************************************"
echo "Testando..."
echo "****************************************************"
/root/nheqminer/Linux_cmake/nheqminer_cpu/nheqminer_cpu -b

echo
echo "****************************************************"
echo "Mining..."
echo "****************************************************"
/root/nheqminer/Linux_cmake/nheqminer_cpu/nheqminer_cpu -l $BTC_SERVER -u $BTC_PAYMENT_ADDRESS.$BTC_WORKER_ID -t $BTC_THREADS