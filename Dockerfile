FROM ubuntu:focal

ENV TZ=Europe/Rome
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    apt-get update && \
    apt-get install build-essential cmake git -y 

RUN git clone --recursive https://github.com/The-OpenROAD-Project/OpenROAD-flow-scripts && \
    cd OpenROAD-flow-scripts && \
    ./etc/DependencyInstaller.sh && \
    ./build_openroad.sh --local

# RUN cd home && \
#     git clone --recursive https://github.com/The-OpenROAD-Project/OpenROAD.git

# WORKDIR /home/OpenROAD

# RUN ./etc/DependencyInstaller.sh

# RUN ./etc/Build.sh    

RUN mv /OpenROAD-flow-scripts /home

ENV PATH /home/OpenROAD-flow-scripts/tools/OpenROAD/build/src:$PATH

SHELL [ "bash", "-c" ]

RUN cd /home/OpenROAD-flow-scripts/flow && \
    source ../setup_env.sh && \
    make

# WORKDIR /home

# RUN echo "source ./setup_env.sh" > ~/.bashrc

# RUN ./build_openroad.sh --local

WORKDIR /home

# CMD ["echo", "Alive!"]
ENTRYPOINT ["openroad", "-gui"]