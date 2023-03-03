init:
	echo "Installing prerequisites on $(shell hostname)"
	sudo dnf install -y podman podman-docker docker-compose wget
	sudo systemctl enable podman.socket
	sudo systemctl start podman.socket
	sudo systemctl status podman.socket
	systemctl --user enable podman.socket
	systemctl --user start podman.socket
	systemctl --user status podman.socket
	sudo touch /etc/containers/nodocker
	export DOCKER_HOST=unix:///run/user/$UID/podman/podman.sock
	sudo curl -H "Content-Type: application/json" --unix-socket /var/run/docker.sock http://localhost/_ping

install-containerlab:
	sudo setsebool -P selinuxuser_execmod 1
	cd /tmp/ && wget https://raw.githubusercontent.com/srl-labs/containerlab/main/get.sh
	chmod +x /tmp/get.sh && sudo /tmp/get.sh

build-kali:
	cd kalilinux && sudo docker-compose up --build -d

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
