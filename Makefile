IMAGEDIR = environment
USER  := $(whoami)

# 2nd: run this 
build: $(IMAGEDIR)/*
	./docker-run.sh scripts/yocto-build.sh environment/$^

build-ubuntu-desktop:
	./docker-run.sh scripts/yocto-build-ubuntu-desktop.sh scripts/ubuntu-env.sh 

# 1st: run this. assumes you have docker.
install-host:
	sudo usermod -aG docker ${USER}
	grep -q -F 'fs.inotify.max_user_watches=1228800' /etc/sysctl.conf
	if [ $? -ne 0 ]; then \
		echo 'fs.inotify.max_user_watches=1228800' | sudo tee -a /etc/sysctl.conf;\
	fi

	sudo mkdir -p /opt/yocto
	sudo chown ${USER}:${USER} /opt/yocto
	sudo chmod 777 /opt/yocto

# need this to switch group to docker immediately
	newgrp docker 
	./docker-build.sh Dockerfile-Ubuntu-20.04
	
# run this if you screw up
bomb:
	sudo rm -fr /opt/yocto/
	sudo mkdir -p /opt/yocto/
	sudo chown ${USER}:${USER} /opt/yocto
	sudo chmod 777 /opt/yocto
	


	