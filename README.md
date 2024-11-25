# Jupyter SSH PyTorch
Container with OpenSSH, JupyterLab, PyTorch to play with AI, ML, with GPUs.

## Main folder
Dockefile and files for building the docker image.

## Compose
To execute the environment.

DockerfileRootPwd just builds from the main image adding the root pwd that is the same as the JUPYTER\_TOKEN.

For starting the environment:
- `cd compose`
- `cp env-sample.txt .env`, then edit it to fit your needs.
- `docker compose up -d`
