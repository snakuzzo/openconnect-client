FROM ubuntu:22.04
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && apt-get install -y expect
RUN apt install kgpg curl net-tools telnet netcat dnsutils iproute2 psmisc screen -y

RUN mkdir -p /var/run/sshd

RUN echo 'deb http://download.opensuse.org/repositories/home:/bluca:/openconnect:/release/Ubuntu_22.04/ /' | tee /etc/apt/sources.list.d/home:bluca:openconnect:release.list
RUN curl -fsSL https://download.opensuse.org/repositories/home:bluca:openconnect:release/Ubuntu_22.04/Release.key | gpg --dearmor | tee /etc/apt/trusted.gpg.d/home_bluca_openconnect_release.gpg > /dev/null

RUN export TERM=xterm-256color

RUN apt update && apt install openconnect -y

WORKDIR /data
RUN chmod 744 /data
CMD ["/data/start"]