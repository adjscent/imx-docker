build:
	./docker-run.sh imx-5.4.70-2.3.0/yocto-build.sh

rebuild:
	./docker-run.sh imx-5.4.70-2.3.0/yocto-rebuild.sh

# 1st: run this 
install-host:
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh

	sudo usermod -aG docker user
	sudo sysctl -w fs.inotify.max_user_watches=12288

	./docker-build.sh Dockerfile-Ubuntu-20.04

	