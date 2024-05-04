# lime-build
Docker container with haxelib and lime installed

# Usage
1. Ensure docker is installed locally
1. Make updates to `Dockerfile` and any needed scripts
1. Run `build.sh` to create the docker container when ready (may take a minute as `apt-get update` may have a good bit to download)
1. Once the image is ready, upload it to docker hub
   1. Windows: From Docker Desktop, select `Push to hub` from the image options