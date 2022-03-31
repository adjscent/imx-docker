IMAGES = environment
list: $(IMAGES)/*

USER  := $(whoami)

# 2nd: run this 
build: $(IMAGES)/*
	./docker-run.sh scripts/yocto-build.sh environment/$^

# 1st: run this 
install-host:
	sudo usermod -aG docker ${USER}
	grep -q -F 'fs.inotify.max_user_watches=1228800' /etc/sysctl.conf
	if [ $? -ne 0 ]; then \
		echo 'fs.inotify.max_user_watches=1228800' | sudo tee -a /etc/sysctl.conf;\
	fi

	sudo mkdir -p /opt/yocto
	sudo chown ${USER}:${USER} /opt/yocto
# need this to switch group to docker immediately
	newgrp docker

	./docker-build.sh Dockerfile-Ubuntu-20.04
	
# run this if you screw up
bomb:
	sudo rm -fr /opt/yocto/
	sudo mkdir -p /opt/yocto/
	sudo chown ${USER}:${USER} /opt/yocto
	sudo chmod 777 /opt/yocto
	


	