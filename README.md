# [OpenROAD](https://openroad.readthedocs.io/en/latest/main/README.html) Dockerfile
Dockerfile for the [OpenROAD integrated chip physical design tool docker image](https://hub.docker.com/r/magiwanders/openroad). 

Build an image:

> :warning: **This builds the image with its current DockerHub name and version `magiwanders/openroad:x.x`. If you want to publish your own fork modify the first line of the Makefile.**

```
make build
```

Create non-volatile container and run it:

```
make container
make start
```

Remove container:
```make clean```

Remove container and image:
```make uninstall```
