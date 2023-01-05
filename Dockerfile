FROM ubuntu:latest

RUN apt-get update && apt-get install sudo wget gpg apt-transport-https git -y

RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg \ 
    && sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg \ 
    && sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list' \ 
    && rm -f packages.microsoft.gpg \
    &&  apt update && apt install code python3-pip build-essential libssl-dev libffi-dev python3-dev -y

RUN mkdir -p /usr/local/share/fonts/meslo && wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf \ 
    https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf \
    https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf \
    https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf && mv *.ttf /usr/local/share/fonts/meslo/


RUN wget https://go.dev/dl/go1.19.4.linux-amd64.tar.gz &&  rm -rf /usr/local/go && tar -C /usr/local -xzf go1.19.4.linux-amd64.tar.gz \
    && echo export PATH=$PATH:/usr/local/go/bin >> /etc/profile && . /etc/profile && go version

RUN useradd -ms /bin/bash vscode

USER vscode

RUN . /etc/profile

WORKDIR /home/vscode

# https://stackoverflow.com/questions/62804653/does-it-make-sense-to-run-a-non-web-application-on-cloud-run
# https://github.com/gitpod-io/openvscode-server

# https://dev.to/codingalex/run-vs-code-remote-tunnels-in-a-container-4lf4

ENTRYPOINT [ "code" ,"tunnel", "--accept-server-license-terms", "--cli-data-dir" ,"/home/vscode/" ]
CMD [ "--random-name" ]
