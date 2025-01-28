#!/bin/bash
docker container create \
  --name $CONTAINER_NAME \
  --gpus all \
  --restart=$RESTART \
  -p $JUPYTERLAB_LISTEN_ADDR:8080 \
  -p $JUPYTERLAB_LISTEN_ADDR_SSH:22 \
  -p $VNC_LISTEN_ADDR:5901 \
  -v $DATAPATH:/root/data \
  -v $(pwd)/logs:/var/log \
  -v $(pwd)/home:/root \
  --env-file .env \
  $IMAGE_ID

