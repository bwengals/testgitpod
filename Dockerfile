FROM jupyter/minimal-notebook:latest

USER root
RUN apt update && apt upgrade -y \
  && apt -y install --no-install-recommends -qq \ 
     curl ca-certificates g++ vim openssh-client \
     unzip tzdata htop tree \
  && apt clean && rm -rf /var/lib/apt/lists/*

USER ${NB_UID}
COPY environment.yml /tmp/environment.yml
RUN mamba env update -f /tmp/environment.yml -n base \
    && conda clean --all -f -y \
    && fix-permissions "${CONDA_DIR}" \
    && fix-permissions "/home/${NB_USER}"

ENV JUPYTER_ENABLE_LAB=1
WORKDIR /home/$NB_USER
USER ${NB_UID}
