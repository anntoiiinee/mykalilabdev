# Official base image
FROM kalilinux/kali-rolling AS base

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y update && apt-get -y dist-upgrade && apt-get -y autoremove && apt-get clean
RUN apt-get update && apt-get -y install kali-tools-top10 exploitdb man-db dirb nikto wpscan uniscan
RUN apt-get update \
    && apt-get install -y openssh-server \
    && mkdir /var/run/sshd \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config \
    && sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config \
    && echo 'root:kali' | chpasswd
RUN service ssh start

EXPOSE 22

ENTRYPOINT [ "/bin/bash" ]