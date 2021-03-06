#!/bin/sh -e

export TARGET_PORT=${TARGET_PORT:-80}
export TARGET_HOST=${TARGET_HOST:-proxyapp}
export CLIENT_MAX_BODY_SIZE=${CLIENT_MAX_BODY_SIZE:-20M}

# Hack to avoid breaking nginx.conf
export host='$host' remote_addr='$remote_addr' proxy_add_x_forwarded_for='$proxy_add_x_forwarded_for' scheme='$scheme' http_upgrade='$http_upgrade' remote_addr='$remote_addr'

envsubst < /nginx.conf.template > /etc/nginx/nginx.conf

if [[ ! ${CUSTOM_CERTS} ]]; then
  /add_self_signed_certs.sh
fi

# Use exec so nginx can get signals directly
exec nginx
echo "Something Broke!"
