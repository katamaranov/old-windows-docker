FROM alpine:latest

RUN apk update && \
    apk add --no-cache \
        qemu-system-i386 \
        git \
        7zip \
        inetutils-telnet \
        expect \
        bash \
        py3-pip \
        wget \
        xvfb \
        curl \
        && rm -rf /tmp/* \
        && rm -rf /var/cache/apk/*

RUN python3 -m venv myenv && source myenv/bin/activate && pip3 install --no-cache-dir websockify flask \
&& wget -qO- https://github.com/novnc/noVNC/archive/refs/tags/v1.3.0.tar.gz | tar xz -C /opt && \
mv /opt/noVNC-1.3.0 /opt/noVNC && \
ln -s /opt/noVNC/vnc.html /opt/noVNC/index.html && mkdir /opt/win1 /opt/win2 /opt/win3

COPY ./supervisord.conf /etc/supervisord.conf

ADD prjct /prjct
RUN chmod +x /prjct

COPY script.sh dos-auto.exp start-qemu.sh /
RUN chmod +x /script.sh /dos-auto.exp /start-qemu.sh

COPY supervisord /usr/bin/supervisord
RUN chmod +x /usr/bin/supervisord

EXPOSE 5335 8888

CMD ["bash", "-c", "source myenv/bin/activate && python /prjct/app.py"]