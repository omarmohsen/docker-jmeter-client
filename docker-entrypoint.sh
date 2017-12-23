#!/bin/bash
#set -e
freeMem=`awk '/MemFree/ { print int($2/1024) }' /proc/meminfo`
s=$(($freeMem/10*8))
x=$(($freeMem/10*8))
n=$(($freeMem/10*2))
export JVM_ARGS="-Xmn${n}m -Xms${s}m -Xmx${x}m"


execute_jmeter(){
jmeter_command=`$JMETER_BIN/jmeter \
    -n \
    -D "java.rmi.server.hostname=${IP}" \
    -D "client.rmi.localport=${RMI_PORT}" \
    -t "${TEST_DIR}/${TEST_PLAN}" \
    -l "${TEST_DIR}/${TEST_PLAN}.jtl" \
    -R $REMOTE_HOSTS`
echo $jmeter_command|grep -E -v 'Engine is busy|java.net.UnknownHostException|java.net.SocketException' 
if [ $? -eq 1 ];then
  echo $jmeter_command
  exit 1
fi
exec tail -f jmeter.log
}
execute_jmeter


