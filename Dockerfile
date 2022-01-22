FROM ubuntu:20.04
RUN apt update && apt upgrade -y && apt install -y sudo sed git build-essential wget openjdk-17-jdk
RUN useradd -r -m -U -d /opt/minecraft -s /bin/bash minecraft
RUN usermod -aG sudo minecraft
RUN su - minecraft
RUN mkdir -p /home/minecraft/{backups,tools,server}
RUN git clone https://github.com/Tiiffi/mcrcon.git /home/minecraft/tools/mcrcon
RUN cd /home/minecraft/tools/mcrcon && sudo gcc -std=gnu11 -pedantic -Wall -Wextra -O2 -s -o mcrcon mcrcon.c
RUN wget https://launcher.mojang.com/v1/objects/125e5adf40c659fd3bce3e66e67a16bb49ecc1b9/server.jar -P /home/minecraft/server
RUN cd /home/minecraft/server
RUN sudo sed 's/eula=false/eula=true/' /home/minecraft/server/eula.txt
RUN sudo java -Xmx1024M -Xms1024M -jar server.jar nogui
