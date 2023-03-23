init:
	echo "Installing prerequisites on $(shell hostname)"
	if [ $$(uname -m) != "x86_64"]; then \
		echo "L'installation de Docker nécessite une architecture x86_64"; \
		exit 1; \
	fi
	sudo apt update && apt install -y apt-transport-https ca-certificates curl gnupg lsb-release
	curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker.gpg
	echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker.gpg] https://download.docker.com/linux/debian $$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	sudo apt update && sudo apt install -y docker-ce docker-ce-cli docker-compose containerd.io
	sudo systemctl start docker && systemctl enable docker
	sudo systemctl status docker

install-containerlab:
	bash -c "$$(curl -sL https://get.containerlab.dev)"

build-kali:
	cd kalilinux && sudo docker build -t kalilinux:latest .

build-arista:
	$(info cEOS file: $(wildcard ../cEOS-lab-*.tar.xz))
	sudo docker import $(wildcard ../cEOS-lab-*.tar.xz) ceosimage:$(shell echo $(wildcard ../cEOS-lab-*.tar.xz) | sed 's/^.*-//;s/\.tar\.xz//')

build-lab:
	cd /home/antoine/mykalilabdev/kalilinux-lab && containerlab deploy

map-lab:
	cd /home/antoine/mykalilabdev/kalilinux-lab && containerlab graph -t kali-arista.clab.yml

destroy:
	cd /home/antoine/mykalilabdev/kalilinux-lab && containerlab destroy