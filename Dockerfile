FROM ubuntu

RUN useradd ubuntu

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata
RUN apt install -y python3 vim less wget tmux curl psmisc htop rsync build-essential cowsay

RUN curl -fsSL https://deb.nodesource.com/setup_17.x | bash -
RUN apt install -y nodejs

WORKDIR /tmp
RUN wget https://ipfs.io/ipns/dist.ipfs.io/go-ipfs/v0.12.0/go-ipfs_v0.12.0_linux-amd64.tar.gz
RUN tar xf go-ipfs_v0.12.0_linux-amd64.tar.gz
RUN mv /tmp/go-ipfs/ipfs /usr/local/bin
RUN rm -rf go-ipfs*

RUN mkdir /home/ubuntu
WORKDIR /home/ubuntu/provider-quest-collector-publisher

COPY . .

RUN chown -R ubuntu. /home/ubuntu

USER ubuntu

RUN mkdir -p node_modules
RUN npm install

ENTRYPOINT ["tail", "-f", "/dev/null"]
