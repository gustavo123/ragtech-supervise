FROM debian:12-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV TERM=xterm

RUN apt-get update

RUN apt-get install -y --no-install-recommends \
    wget \
    ca-certificates \
    libc6 \
    libstdc++6 \
    libncurses5 \
    ncurses-bin \
    libqt5core5a \
    libqt5script5 \
    libqt5sql5 \
    libqt5sql5-sqlite \
    libqt5gui5 \
    libqt5widgets5 \
    libqt5svg5 \
    usbutils \
    udev

WORKDIR /tmp

RUN wget -O supervise.sh https://ragtech.com.br/Softwares_download/supervise-8.9-2.sh

RUN chmod +x supervise.sh

RUN ./supervise.sh --noexec --target /tmp/supervise

RUN printf "\n" | dpkg -i /tmp/supervise/Supervise.deb

RUN test -x /opt/supervise/supsvc

RUN rm -rf /tmp/supervise \
    /tmp/supervise.sh \
    /var/lib/apt/lists/*

EXPOSE 4470

WORKDIR /opt/supervise

ENTRYPOINT ["/bin/sh", "-c", "/opt/supervise/supsvc"]
