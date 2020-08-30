# TODO: pick a smaller starting container
FROM ubuntu:latest
#RUN apt-get update && apt-get install -y software-properties-common
#RUN add-apt-repository ppa:haxe/releases -y
#RUN apt-get update -y && apt-get install -y haxe
#RUN mkdir /var/haxelib
#RUN haxelib setup /var/haxelib
#RUN yes | haxelib install lime
#RUN yes | haxelib run lime setup
#RUN cp "/var/haxelib/lime/7,8,0/templates/bin/lime.sh" /usr/local/bin/lime
#RUN chmod 755 /usr/local/bin/lime
#RUN haxelib version
#RUN lime --version
#RUN haxelib path lime
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]