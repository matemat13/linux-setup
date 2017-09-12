if [ "$(id -u)" != "0" ]; then
  exec sudo "$0" "$0" 
fi

service network-manager restart
