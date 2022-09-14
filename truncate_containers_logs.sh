#!/bin/bash
CurrentTime=$(date +"%F_%z_%T" | tr -d [=:=][=-=][=+=])
CurrentDate=$(date +"%F" | tr -d [=:=][=-=][=+=])

mkdir -p "$HOME/cleanup-LogsOfDocker-everyday/"
WORKDIR="$HOME/cleanup-LogsOfDocker-everyday/"
cd "$WORKDIR"

for HOST in k8sw-01r k8sw-02r k8sw-03r
do
        echo $CurrentTime >> "$WORKDIR/$CurrentDate.log"
        ssh -t $HOST 'hostname; date; sudo find /var/lib/docker/containers/ -type f -name "*.log" -size +1G  -exec ls -lht {} +' >> "$WORKDIR/$CurrentDate.log"
        ssh -t $HOST 'hostname; date; sudo find /var/lib/docker/containers/ -type f -name "*.log" -size +1G  -exec truncate -s 0 {} +' >> "$WORKDIR/$CurrentDate.log"
        echo $CurrentTime >> "$WORKDIR/$CurrentDate.log"
done
