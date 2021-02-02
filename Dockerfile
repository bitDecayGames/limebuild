FROM ubuntu:latest

# this env var is read by haxelib and will hopefully keep us from having to run `haxelib setup` during
# github actions
ENV HAXELIB_PATH=/var/haxelib
RUN echo "HAXELIB_PATH=${HAXELIB_PATH}" >> /etc/environment

RUN apt-get update && apt-get install -y software-properties-common
RUN add-apt-repository ppa:haxe/releases -y
# install zip and git to be able to package the build and for getting dependencies
# install java for lime html5 builds with the `-final` flag. needed for minifying among other things
RUN apt-get update -y && apt-get install -y haxe zip git default-jre

RUN mkdir $HAXELIB_PATH
RUN haxelib setup $HAXELIB_PATH
RUN haxelib install lime --always
RUN haxelib run lime setup --always

# Create a simple script that runs lime as `lime` doesn't make it onto the path from just
# running `run lime setup` for some reason
RUN echo "haxelib run lime \$@" > /usr/local/bin/lime && \
    chmod +x /usr/local/bin/lime

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
