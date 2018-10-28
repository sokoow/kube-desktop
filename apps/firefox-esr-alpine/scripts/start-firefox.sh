#!/bin/sh

echo "Machine ID:"
cat /etc/machine-id
chown -R firefox: /home/firefox
firefox
