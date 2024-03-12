#!/usr/bin/env bash
PUBLIC_DIR="/var/www/html"
TIMESTAMP="date +"%F_%T" -d+3hours"
cd $PUBLIC_DIR

if [ $# -ne 0 ]
then
        TARGET_SITE=$1
        # Проверка на существоавние каталога сайта
        if [ -d $TARGET_SITE ]
        then
                true
        else
                echo -e "\nНет такого каталога по пути $PUBLIC_DIR\n"
                ls -lhtd * | grep -E '^d' | awk '{print $NF}' | xargs
                echo ""
                exit 1
        fi

        # Операция архивирования
        echo -ne "\nStart at: " && date && tar cf - $TARGET_SITE | pigz -9 -p 19 > $TARGET_SITE--$($TIMESTAMP).tar.gz && echo -n "Finished at: " && date
        ls -lht $PUBLIC_DIR/*.tar.gz
        echo -e "\n"
else
        echo -e "\nЧтобы выполнить архивирование нужного сайта"
        echo -e "Скрипт $0 принимает 1 аргумент названием одного из каталогов по пути $PUBLIC_DIR:\n"
        echo -e "Пример: make_backup_site.sh site777\n"
        ls -lhtd * | grep -E '^d' | awk '{print $NF}' | xargs
        echo ""
        exit 1
fi
