FROM ubuntu:latest

# the versions of the linux/haxe ecosystem to install. Update these when it's time to upgrade
# these versions must coordinate with a version available here: https://launchpad.net/~haxe/+archive/ubuntu/releases
ENV UBUNTU_VERSION=20.04.1
ENV HAXE_VERSION=4.2.5
ENV LIME_VERSION=7.9.0

# this env var is read by haxelib and will hopefully keep us from having to run `haxelib setup` during
# github actions
ENV HAXELIB_PATH=/var/haxelib
RUN echo "HAXELIB_PATH=${HAXELIB_PATH}" >> /etc/environment

# Haxe repositories as discussed here: https://haxe.org/download/linux/
RUN apt-get update && \
    apt-get install --no-install-recommends -y software-properties-common && \
    add-apt-repository ppa:haxe/releases -y

# install zip and git to be able to package the build and for getting dependencies
# install java for lime html5 builds with the `-final` flag. needed for minifying among other things
# I tried `openjdk-7-jre-headless` java version to see if our image can be made smaller, but it only saved <100MB
# which doesn't seem worth the trouble of making sure everything works
RUN apt-get install --no-install-recommends -y \
        zip \
        git \
        default-jre \
        haxe=1:${HAXE_VERSION}-1~ubuntu${UBUNTU_VERSION}~ppa1 \
    && rm -rf /var/lib/apt/lists/*


# setup haxelib and install/setup lime
RUN mkdir $HAXELIB_PATH && \
    haxelib setup $HAXELIB_PATH && \
    haxelib install lime ${LIME_VERSION} --always && \
    haxelib run lime setup --always

# Create a simple script that runs lime as `lime` doesn't make it onto the path from just
# running `run lime setup` for some reason
RUN echo "haxelib run lime \$@" > /usr/local/bin/lime && \
    chmod +x /usr/local/bin/lime

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
