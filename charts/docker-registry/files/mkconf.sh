#!/bin/sh

cat <<EOF
$(cat /etc/ssl/openssl.cnf)

[SAN]
subjectAltName=DNS:$1,DNS:www.$1,DNS:$1.default.svc.cluster.local
EOF
