FROM alpine:3.21.3

RUN addgroup -S ssh_group -g 1000 && \
    adduser -S sshuser -G ssh_group --uid 1000 -s /bin/ash && \
    sed -i "s#sshuser:!#sshuser:*#g" /etc/shadow && \
    mkdir /data && \
    chmod 777 /data 

# ssh-keygen -A generates all necessary host keys (rsa, dsa, ecdsa, ed25519) at default location.
RUN    apk update \
    && apk add openssh rsync \
    && ssh-keygen -A

RUN wget https://github.com/ochinchina/supervisord/releases/download/v0.7.3/supervisord_0.7.3_Linux_64-bit.tar.gz -O /tmp/supervisord.tar.gz && \
    tar zxvf /tmp/supervisord.tar.gz -C /tmp && \
    find /tmp -type f && \
    cp /tmp/supervisord_0.7.3_Linux_64-bit/supervisord_static  /usr/bin/supervisord && \
    rm -rf /tmp/*
    
# This image expects AUTHORIZED_KEYS environment variable to contain your ssh public key.
COPY docker-entrypoint.sh /
COPY src/empty-folders.sh /usr/bin/empty-folders.sh
COPY src/supervisor.conf /etc/

EXPOSE 22
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/bin/supervisord","-c","/etc/supervisor.conf"]
