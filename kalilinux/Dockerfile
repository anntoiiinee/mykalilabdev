# Official base image
FROM kalilinux/kali-rolling

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y update && apt-get -y dist-upgrade && apt-get -y autoremove && apt-get clean
RUN apt-get update && apt-get -y install kali-tools-top10 exploitdb man-db dirb nikto wpscan uniscan

WORKDIR /root
CMD ["/bin/bash"]
