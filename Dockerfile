FROM ubuntu:focal

# Handle timezone problems
ENV TZ=Europe/Rome
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone 

# Install graphical terminal
RUN apt update && apt install xterm dbus-x11 -y

# Install build necessities
RUN apt-get install build-essential cmake curl tar sudo git -y 

RUN cd home && \
    git clone --recursive https://github.com/The-OpenROAD-Project/OpenROAD-flow-scripts && \
    cd OpenROAD-flow-scripts && \
    ./etc/DependencyInstaller.sh && \
    ./build_openroad.sh --local

ENV PATH /home/OpenROAD-flow-scripts/tools/OpenROAD/build/src:$PATH

SHELL [ "bash", "-c" ]

RUN cd /home/OpenROAD-flow-scripts/flow && \
    source ../setup_env.sh && \
    make

RUN cd /home && \
    touch ORgui.sh && \
    echo "#!/bin/bash" >> ORgui.sh && \
    echo "xterm -e 'openroad -gui'" >> ORgui.sh && \
    chmod +x ORgui.sh

WORKDIR /home

ENTRYPOINT ["xterm"]

# ENTRYPOINT ["openroad", "-gui"]