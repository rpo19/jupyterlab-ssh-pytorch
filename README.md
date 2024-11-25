# Jupyter SSH PyTorch
Container with OpenSSH, JupyterLab, PyTorch to play with AI, ML, with GPUs.

## Main folder
Dockefile and files for building the docker image.

## Make release
```
make release VERSION=2.5.1-cuda12.4-cudnn9-runtime.1
```

## Install
To execute the environment you could either clone the repository or download and extract one of the releases. 

DockerfileRootPwd just builds from the main image adding the root pwd that is the same as the JUPYTER\_TOKEN.

For starting the environment:
- Only if you cloned the repository: `cd compose`
- `cp env-sample.txt .env`, then edit it to fit your needs.
- `docker compose up -d`
