#!/usr/bin/env bash

FILE="repolist"
LOGFILE="tsohacheck.log"
PYTHON="python3"
PYLINT="pylint3"

echo "Start: $(date -Iminutes)" >> $LOGFILE
while read repo
do
student=$(echo "$repo"|sed "s#.*/\([a-zA-Z0-9_+-]*\)/[a-zA-Z0-9_+-]*\(\.git\)\?#\1#")
  if GIT_TERMINAL_PROMPT=0 git clone -q "$repo" "$student"
  then
    status="OK"
  else
    status="FAIL"
  fi
  echo "$repo $status"
  echo "$repo $status" >> $LOGFILE
done < $FILE
echo "End: $(date -Iminutes)" >> $LOGFILE

for d in * ; do
  if [ -d "$d" ]; then
    (
      cd "$d" || exit
      {
        echo "Extra files/directories:"
        find . -path ./venv -prune -o -name ".DS_Store" -print
        find . -path ./venv -prune -o -name "*.pyc" -print
        find . -type d -name "venv" -print
        echo
        echo "Possibly problematic files:"
        find . -path ./venv -prune -o -name ".vscode" -print
        find . -path ./venv -prune -o -name ".idea" -print
        echo
        echo "Pylint:"
        find . -path ./venv -prune -o -name "*.py" -exec $PYLINT --disable=missing-docstring --disable=import-error --reports=n {} \;
        echo
        echo "Custom checks:"
        $PYTHON ../custom.py
      } >> $LOGFILE
    )
  fi
done
