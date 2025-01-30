ARG PYTORCH_VERSION=2.5.1-cuda12.4-cudnn9-devel

FROM pytorch/pytorch:${PYTORCH_VERSION}

ARG APT_PACKAGES="supervisor openssh-server openssh-sftp-server git python3 python-is-python3 python3-venv tmux vim fish locales xorg openbox xterm tigervnc-standalone-server tigervnc-common"
ARG PIP_PACKAGES="jupyterlab ipykernel"

RUN mkdir -p /workspace/notebooks
RUN mkdir -p /workspace/data

VOLUME /workspace/data
VOLUME /var/log
VOLUME /root

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y ${APT_PACKAGES}
RUN add-apt-repository ppa:flexiondotorg/nvtop
RUN apt-get install -y nvtop
RUN rm -rf /var/lib/apt/lists/*

RUN sed -i -e '/en_US.UTF-8/s/^# //g' -e '/it_IT.UTF-8/s/^# //g' /etc/locale.gen
RUN locale-gen

RUN python -m pip install --upgrade pip
RUN python -m pip install ${PIP_PACKAGES}

RUN jupyter lab --generate-config

RUN mkdir /var/run/sshd && chmod 0755 /var/run/sshd
COPY ssh_root_login.conf /etc/ssh/sshd_config.d/ssh_root_login.conf

RUN mkdir -p /etc/supervisor/
COPY supervisord.conf /etc/supervisor/supervisord.conf

RUN mkdir -p /root/.config/openbox
COPY autostart /root/.config/openbox/autostart

RUN /opt/conda/bin/conda init bash
RUN /opt/conda/bin/conda init fish
RUN /opt/conda/bin/python -m ipykernel install --user --name base --display-name "Conda (base)"

RUN mkdir -p /etc/environment.supervisor.d/

WORKDIR /root

EXPOSE 8080
EXPOSE 22
CMD ["bash", "-c", "source /etc/environment.supervisor.d/*; exec supervisord -c /etc/supervisor/supervisord.conf"]
