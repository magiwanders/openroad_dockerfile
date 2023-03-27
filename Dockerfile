FROM ubuntu:focal

ENV TZ=Europe/Rome
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    apt-get update && \
    apt-get install build-essential cmake git -y 

RUN cd home && \
    git clone --recursive https://github.com/The-OpenROAD-Project/OpenROAD.git

WORKDIR /home/OpenROAD

RUN ./etc/DependencyInstaller.sh

RUN ./etc/Build.sh    

ENV PATH /home/OpenROAD/build/src:$PATH

WORKDIR /home

# RUN echo "source ./setup_env.sh" > ~/.bashrc

# RUN git clone --recursive https://github.com/The-OpenROAD-Project/OpenROAD-flow-scripts && \
#     cd OpenROAD-flow-scripts && \
#     ./etc/DependencyInstaller.sh

WORKDIR /home

ENTRYPOINT ["openroad", "-gui"]