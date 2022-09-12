#!/bin/bash

##version=1.2
mkdir -p "$HOME/job_cleanup-7days/"
cd  "$HOME/job_cleanup-7days/"

for jobname in $(kubectl -n mathmachine-avi-prod get job -o=jsonpath="{.items[?(@.status.succeeded==1)].metadata.name}")
do
    jobAge=$( kubectl -n mathmachine-avi-prod get job/$jobname -o=json | jq .status.completionTime | jq -r 'strptime("%Y-%m-%dT%H:%M:%SZ") | strftime("%Y%m%d")')
    day7=$( date -d '-7days' +%Y%m%d)
    if [[ $jobAge -lt $day7 ]]; then
        echo -e "Delete job " $jobname "date complite" $jobAge"\n" >> ./$(date +%Y%m%d)_clearupJB.log
        kubectl -n mathmachine-avi-prod delete job/$jobname
    fi
done
