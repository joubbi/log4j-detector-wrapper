#!/usr/bin/env bash
#######################################################################
#                                                                     #
# Find a java binary and search the specified directories for log4j.  #
# Report about findings.                                              #
#                                                                     #
# Uses https://github.com/mergebase/log4j-detector to detect log4j.   #
#                                                                     #
# Written by Farid Joubbi 2021-12-14                                  #
#                                                                     #
#######################################################################

LOG4JDETECTOR="log4j-detector-2021.12.14.jar"

if [ -d "/opt" ]; then
  SCANPATHS="/opt /var /usr /root"
else
  SCANPATHS="/var /usr /root"
fi


echo "---------------------------------------------------------------"
echo "                     -== Log4j Report ==-"
echo "Hostname:      $(hostname)"
echo "Date:          $(date)"
echo "To be scanned: $SCANPATHS"

# Hopefully we will find a java executable in the PATH. If we do, use it and exit.
if file=$(command -v java); then
  echo "Java location: ${file}"
  echo "---------------------------------------------------------------"
  "${file}" -jar "$LOG4JDETECTOR" $SCANPATHS 
  echo "---------------------------------------------------------------"
  exit
fi


# If there was no java executable in PATH, try to find one, use the first found and exit.
for fs in $(mount -v | grep -E -v "nfs|oracle|tmpfs|lofs|ctfs|objfs|fd|devfs|mntfs|sharefs|odm|proc|devpts|sysfs" | awk '{print $3}'); do
  find "${fs}" -xdev -type f -regextype sed -regex ".*java" -print0 | while IFS= read -r -d '' file; do
    if file "${file}" | grep "executable" &>/dev/null; then
      echo "Java Location:  ${file}"
      echo "---------------------------------------------------------------"
      "${file}" -jar "$LOG4JDETECTOR" $SCANPATHS
      echo "---------------------------------------------------------------"
      exit
    fi
  done
done

echo "Java not found on this system!"
echo "---------------------------------------------------------------"
exit 0
