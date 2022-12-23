FROM ubuntu:latest

RUN apt-get update && apt-get install sudo wget gpg apt-transport-https git -y

RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg \ 
    && sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg \ 
    && sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list' \ 
    && rm -f packages.microsoft.gpg \
    &&  apt update && apt install code -y

RUN useradd -ms /bin/bash vscode

USER vscode

WORKDIR /home/vscode

ENTRYPOINT [ "code" ,"tunnel", "--accept-server-license-terms", "--cli-data-dir" ,"/home/vscode/" ]
CMD [ "--random-name" ]
