# syntax=docker/dockerfile:1

FROM debian:11-slim

RUN apt update \
  && apt upgrade -y \
  && apt install lighttpd -y \
  && apt clean all

RUN rm -rf /etc/lighttpd && mkdir /etc/lighttpd

RUN cat <<EOF > /etc/lighttpd/lighttpd.conf
  var.server_root = "/var/www"
  var.conf_dir    = "/etc/lighttpd"

  server.document-root = server_root + "/lighttpd"

  server.port = 80

  server.username = "www-data"
  server.groupname = "www-data"

  server.max-fds = 16384

  index-file.names += (
    "index.html", 
  )

  include_shell "/usr/share/lighttpd/create-mime.conf.pl"
EOF

WORKDIR /var/www/lighttpd
RUN rm -rf *
COPY . .

USER www-data

EXPOSE 80

CMD [ "lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf" ]
