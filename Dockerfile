FROM ubuntu:latest
RUN apt-get update && apt-get install -y software-properties-common
RUN add-apt-repository ppa:haxe/releases -y
# install zip and git to be able to package the build and for getting dependencies
RUN apt-get update -y && apt-get install -y haxe zip git
RUN mkdir /var/haxelib
RUN haxelib setup /var/haxelib
RUN yes | haxelib install lime
RUN yes | haxelib run lime setup
RUN cp "/var/haxelib/lime/7,8,0/templates/bin/lime.sh" /usr/local/bin/lime
RUN chmod 755 /usr/local/bin/lime
RUN haxelib version
RUN lime --version
RUN haxelib path lime
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
