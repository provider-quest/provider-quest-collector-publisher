FROM ubuntu

RUN useradd ubuntu

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata
RUN apt install -y python3 vim less wget tmux curl psmisc htop rsync build-essential cowsay

RUN curl -fsSL https://deb.nodesource.com/setup_17.x | bash -
RUN apt install -y nodejs

RUN mkdir /home/ubuntu
WORKDIR /home/ubuntu/provider-quest-collector-publisher

COPY . .

RUN chown -R ubuntu. /home/ubuntu

USER ubuntu

RUN mkdir -p node_modules
RUN npm install

ENTRYPOINT ["tail", "-f", "/dev/null"]
