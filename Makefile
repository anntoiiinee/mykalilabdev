build-tinycore:
	cd tinycore && sudo

build-arista:
	$(info cEOS file: $(wildcard cEOS-lab-*.tar.xz))
	sudo podman import $(wildcard cEOS-lab-*.tar.xz) ceosimage:$(shell echo $(wildcard cEOS-lab-*.tar.xz) | sed 's/^.*-//;s/\.tar\.xz//')

build-lab:
	mkdir ~/kalilinux-lab
	cd ~/kalilinux-lab

stop-kali:
	echo "stopping kali image"
	cd kalilinux && sudo docker-compose stop

destroy-kali:
	echo "destroying kali image"
	cd kalilinux && sudo docker-compose down

bash-%:
	echo "running bash on $*"
	sudo podman exec -it -u0 $* /bin/bash
