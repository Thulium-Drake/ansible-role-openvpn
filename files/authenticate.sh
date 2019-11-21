#!/bin/bash

PWFILE=/etc/openvpn/private/passwd

NOW=$(date '+%Y%m%d')

while read user pass expiration
do
  [ -z "$user" ] && continue
  [ "${user:0:1}" = "#" ] && continue
  [ "$user" != "$username" ] && continue

  [ "$pass" == "$password" ] && {
    [ -z "$expiration" ] || {

      # user expired?
      [ "$expiration" -lt "$NOW" ] && break
    }
    exit 0
  }

  break # password mismatch
done < $PWFILE

cat << _EOF_ | /bin/mail -s "OpenVPN $(hostname) login failure" root

Details:

untrusted_ip=$untrusted_ip
username=$username
password=$password
expiration=$expiration (now=$NOW)
_EOF_

exit 1
