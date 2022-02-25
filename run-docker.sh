#! /bin/bash

docker rm -f pq-collect
docker run -it --cap-add=SYS_ADMIN --entrypoint /bin/bash --cap-add=SYS_ADMIN --name pq-collect pq-collector-publisher
#docker run -it -u 0 --cap-add=SYS_ADMIN --entrypoint /bin/bash --cap-add=SYS_ADMIN --name pq-collect pq-collector-publisher
