FROM ubuntu:latest

RUN apt-get update && apt-get upgrade -y && apt-get install locales curl unzip git sudo -y

RUN sed -i "s/# en_US.UTF-8/en_US.UTF-8/" /etc/locale.gen \
  && locale-gen
ENV LANG=en_US.UTF-8

RUN adduser --gecos '' --disabled-password coder \
  && echo "coder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/nopasswd
 

RUN curl -fsSL https://code-server.dev/install.sh | sh

# Apply VS Code settings
# COPY deploy-container/settings.json .local/share/code-server/User/settings.json

# Use bash shell
ENV SHELL=/bin/bash

EXPOSE 8080
# This way, if someone sets $DOCKER_USER, docker-exec will still work as
# the uid will remain the same. note: only relevant if -u isn't passed to
# docker-run.
USER 1000
ENV USER=coder
WORKDIR /home/coder


ENTRYPOINT [ "code-server" , "--auth", "none", "--bind-addr", "0.0.0.0:8080"]

# https://github.com/coder/deploy-code-server/tree/main/deploy-container
