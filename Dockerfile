ARG PYTORCH_VERSION=2.5.1-cuda12.4-cudnn9-runtime

FROM pytorch/pytorch:${PYTORCH_VERSION}

ARG APT_PACKAGES="supervisor openssh-server openssh-sftp-server git python3 python-is-python3 ppython3-venv tmux vim"
ARG PIP_PACKAGES="jupyterlab pandas numpy requests"

RUN mkdir -p /workspace/notebooks
RUN mkdir -p /workspace/data

VOLUME /workspace/data
VOLUME /var/log
VOLUME /root

RUN apt-get update
RUN apt-get install -y ${APT_PACKAGES}
RUN rm -rf /var/lib/apt/lists/*

RUN python -m pip install --upgrade pip
RUN python -m pip install ${PIP_PACKAGES}

RUN mkdir /var/run/sshd && chmod 0755 /var/run/sshd
COPY ssh_root_login.conf /etc/ssh/sshd_config.d/ssh_root_login.conf

COPY supervisord.conf /etc/supervisord.conf

WORKDIR /workspace

EXPOSE 8080
EXPOSE 22
CMD ["supervisord", "-c", "/etc/supervisord.conf"]
