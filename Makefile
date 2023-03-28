version=magiwanders/openroad:0.2

default: help

help:
	cat README.md

all:
	docker image build -t $(version) .

# container: 
# 	docker container create -it --name openroad $(version) bash
# 	docker container ls -a

container:
	open -a XQuartz
	xhost + 127.0.0.1
	docker container create -e DISPLAY=host.docker.internal:0 -v /tmp/.X11-unix:/tmp/.X11-unix -it --name openroad $(version)

start:
	docker container start -i openroad
	
clean:
	docker container stop openroad
	docker container rm openroad
	docker container ls -a

uninstall:
	docker container rm openroad
	docker image rm $(version)
	
