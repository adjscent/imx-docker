IMAGEDIR := environment
USER  := $(shell whoami)

DOCKER_IMAGE_TAG := imx-yocto
DOCKER_WORKDIR := /opt/yocto

prep:
	sudo chown ${USER}:${USER} -R /opt/yocto
	sudo chmod 777 -R /opt/yocto    
	sudo mkdir -p /opt/yocto/.repo

# 2nd: run this 
build: $(IMAGEDIR)/*
	./docker-run.sh scripts/yocto-build.sh $^

build-ubuntu-desktop-evk: 
	./docker-run.sh scripts/yocto-build-ubuntu-desktop.sh scripts/ubuntu-env-evk.sh 

build-ubuntu-desktop-mek: 
	./docker-run.sh scripts/yocto-build-ubuntu-desktop.sh scripts/ubuntu-env-mek.sh 

enter-docker:
	docker run -it $(DOCKER_IMAGE_TAG) bash

# 1st: run this. assumes you have docker.
install-host: 
	echo "you may need to run this again after you login and logout."
	sudo usermod -aG docker ${USER}
	# grep -q -F 'fs.inotify.max_user_watches=1228800' /etc/sysctl.conf
	# if [ $? -ne 0 ]; then \
	# 	echo 'fs.inotify.max_user_watches=1228800' | sudo tee -a /etc/sysctl.conf;\
	# fi

	./docker-build.sh Dockerfile-Ubuntu-20.04
	
# run this if you screw up
bomb:
	sudo rm -fr /opt/yocto/
	sudo mkdir -p /opt/yocto/
	sudo chown ${USER}:${USER} -R /opt/yocto
	sudo chmod 777 -R /opt/yocto
	sudo mkdir -p /opt/yocto/.repo
	


	
