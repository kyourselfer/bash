#!/usr/bin/bash
CurrentTime=$(date +"%F_%z_%T" | tr -d [=:=][=-=][=+=])
CurrentDate=$(date +"%F" | tr -d [=:=][=-=][=+=])

cd /home/asmgtuusr/cleanup-LogsOfDocker-everyday/

for HOST in vasmgtu01 vasmgtu02 vasmgtu03 vasmgtu04 vasmgtu05 vasmgtu06
do
        echo $CurrentTime >> $0.$CurrentDate.log
        ssh -t $HOST 'sudo find /var/lib/docker/containers/ -type f -name "*.log" -size +1G  -exec ls -lht {} +' >> $0.$CurrentDate.log
        ssh -t $HOST 'sudo find /var/lib/docker/containers/ -type f -name "*.log" -size +1G  -exec truncate -s 0 {} +' >> $0.$CurrentDate.log
        echo $CurrentTime >> $0.$CurrentDate.log
done
