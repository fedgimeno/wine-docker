FROM ubuntu:focal
ENV DEBIAN_FRONTEND noninteractive

# wine needs i386 to to run i386 binaries
RUN dpkg --add-architecture i386
RUN apt-get update -y
RUN apt install sudo wget git gcc unzip gnupg2 -y
RUN apt install software-properties-common -y

RUN wget -nc https://dl.winehq.org/wine-builds/winehq.key && \
    apt-key add winehq.key && \
    add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ focal main' && \
    apt install --install-recommends winehq-stable -y

RUN apt install libasound2-dev pulseaudio -y
COPY download_gecko_mono.sh /root/download_gecko_and_mono.sh
RUN chmod +x /root/download_gecko_and_mono.sh \
    && /root/download_gecko_and_mono.sh "$(wine --version | sed -E 's/^wine-//')"

#Create user so we don't run wine as root
RUN useradd -u 1000 -d /home/wine -m -s /bin/bash wine
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/wine && mkdir -p /etc/sudoers.d \
    echo "wine:x:${uid}:${gid}:wine,,,:/home/wine:/bin/bash" >> /etc/passwd && \
    echo "wine:x:${uid}:" >> /etc/group && \
    echo "wine ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/wine && \
    chmod 0440 /etc/sudoers.d/wine && \
    chown ${uid}:${gid} -R /home/wine

USER wine
