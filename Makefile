IMAGE := imx-5.4.70-2.3.0

build:
	./docker-run.sh ${IMAGE}/yocto-build.sh

rebuild:
	./docker-run.sh ${IMAGE}/yocto-rebuild.sh

# 1st: run this 
install-host:
	curl -fsSL https://get.docker.com -o get-docker.sh
	sudo sh get-docker.sh
	rm get-docker.sh

	sudo usermod -aG docker user
	grep -q -F 'fs.inotify.max_user_watches=1228800' /etc/sysctl.conf
	if [ $? -ne 0 ]; then
	echo 'fs.inotify.max_user_watches=1228800' | sudo tee -a /etc/sysctl.conf
	fi

	./docker-build.sh Dockerfile-Ubuntu-20.04
	
# run this if you screw up
bomb:
	rm -fr /opt/yocto
	


	