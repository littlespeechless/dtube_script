FROM ubuntu:20.04

# Install base utilities
RUN apt update && \
    apt-get install -y wget iputils-ping iperf traceroute git psmisc && \
    apt-get clean
    
# Install anaconda 
ENV CONDA_DIR /opt/conda
RUN wget https://repo.anaconda.com/archive/Anaconda3-2021.11-Linux-x86_64.sh -O ~/anaconda.sh && \
    bash ~/anaconda.sh -b -p /opt/conda
# Put conda in path so we can use conda activate
ENV PATH=$CONDA_DIR/bin:$PATH

# Install IPFS 
RUN wget https://dist.ipfs.io/go-ipfs/v0.11.0/go-ipfs_v0.11.0_linux-amd64.tar.gz && \
    tar -xvzf go-ipfs_v0.11.0_linux-amd64.tar.gz && \
    cd go-ipfs && \
    bash install.sh
    
# Init IPFS and setup system udp
RUN ipfs init && \
    ipfs config --json Gateway.PublicGateways '{"localhost": {"Paths": ["/ipfs"],"UseSubdomains": false} }'

# get custom IPFS binary
RUN cd ~ && \
    git clone https://github.com/w774908117/ipfs_bin.git
# Install python libs
RUN conda install -y lockfile && \
    pip install icmplib

COPY init.sh /init.sh

VOLUME ["/result", "/scripts"]

ENTRYPOINT ["bash", "/init.sh"]
