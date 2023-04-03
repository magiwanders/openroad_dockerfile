version=magiwanders/openroad:0.2

default: help

help:
	cat README.md

build:
	docker image build -t $(version) .

container:
	open -a XQuartz
	xhost + 127.0.0.1
	docker container create -e DISPLAY=host.docker.internal:0 -v /tmp/.X11-unix:/tmp/.X11-unix -it --name openroad-gui $(version)

start:
	docker container start -i openroad-gui

clean:
	docker container stop openroad-gui
	docker container rm openroad-gui
	docker container ls -a

uninstall:
	docker container rm openroad-gui
	make .uninstall-image

.uninstall-image:
	docker container rm openroad
	docker image rm $(version)
	
