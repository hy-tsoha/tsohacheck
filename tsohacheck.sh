#!/usr/bin/env bash -


FILE="repolist"
LOGFILE="tsohacheck.log"

date -Iminutes >> $LOGFILE
while read repo
do
  GIT_TERMINAL_PROMPT=0 git clone -q $repo
  if [ $? -eq 0 ]; then
    status="OK"
  else
    status="FAIL"
  fi
  echo "$repo $status"
  echo "$repo $status" >> $LOGFILE
done < $FILE

for d in * ; do
  if [ -d $d ]; then
    cd $d
    echo "Extra files/directories:" >> $LOGFILE
    find . -path ./venv -prune -o -name ".DS_Store" -print >> $LOGFILE
    find . -path ./venv -prune -o -name "*.pyc" -print >> $LOGFILE
    find . -type d -name "venv" -print >> $LOGFILE
    echo "Possibly problematic files:" >> $LOGFILE
    find . -path ./venv -prune -o -name ".vscode" -print >> $LOGFILE
    find . -path ./venv -prune -o -name ".idea" -print >> $LOGFILE
    echo "Pylint:" >> $LOGFILE
    find . -path ./venv -prune -o -name "*.py" -exec pylint3 --disable=missing-docstring --disable=import-error --reports=n {} \; >> $LOGFILE
    cd ..
  fi
done
