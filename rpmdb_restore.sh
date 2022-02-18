#!/bin/bash
# get-package-list-from-backup.sh
set -e
set -x
cd /var/adm/backup/rpmdb
for gzipfile in *.gz; do (
 base=${gzipfile/.gz/}
 dir=/var/tmp/rpmdb-restore-$base
 mkdir $dir
 cp $gzipfile $dir
 cd $dir
 gunzip $gzipfile; mv $base Packages
 rpm --dbpath $dir -qa | sort > qa.list )
done

# --- match qa.list
# vimdiff /var/tmp/rpmdb-restore-Packages-20150625/qa.list /var/tmp/rpmdb-restore-Packages-20160311/qa.list
