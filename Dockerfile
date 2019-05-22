FROM openjdk:8-jre-alpine
LABEL maintainer "briankanya"
RUN apk add --no-cache -U \
  unzip \
  bash \
  curl wget
RUN mkdir /TekkitCServer
WORKDIR /TekkitCServer
RUN wget http://servers.technicpack.net/Technic/servers/tekkit/Tekkit_Server_3.1.2.zip
RUN unzip /TekkitCServer/Tekkit_Server_3.1.2.zip
RUN mkdir /TekkitCServer/plugins
ADD ops.txt /TekkitCServer
ADD white-list.txt /TekkitCServer
ADD server.properties /TekkitCServer
WORKDIR /TekkitCServer/plugins
RUN wget https://media.forgecdn.net/files/757/757/ChopTree2.jar
WORKDIR /TekkitCServer
RUN rm /TekkitCServer/Tekkit_Server_3.1.2.zip
RUN chmod +x /TekkitCServer/launch.sh

EXPOSE 25565

RUN addgroup -g 1000 tekkit \
  && adduser -Ss /bin/false -u 1000 -G tekkit -h /home/tekkit tekkit \
  && chown -R tekkit:tekkit /TekkitCServer /home/tekkit

USER tekkit


CMD /TekkitCServer/launch.sh