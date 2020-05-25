# nextchain-docker
This repo is for building Docker images that run the Nextchain nextd node in a container for easy deployment so we can interact with the next blockchain using JSON-RPC. To build, deploy and interact with the container itself please visit __this__ example repo (in development). Each directory contains the build for a specific wallet version, which is currently limited to one version: 3.5.0.

Please note that this software is considered alpha and could really use some improvements, do NOT use this in production. For starters, there's no mechanism in place to verify the validity of the wallet by comparing SHA256 hashes of the commit because the team hasn't published the hash (they are aware though) yet. Also, the example project is not functioning correctly and there is reason to believe its fault lies within the nextd image. Please help me figure that out!

## Prerequisites
- Docker client installed on your machine (https://docs.docker.com/desktop/)
- Experience with Docker (though not required, but highly recommended)

## step 1: clone this project
You can clone this project with the following commands:
```
git clone https://github.com/X-AE-A12/nextchain-docker.git
cd nextchain-docker
```

## step 2: build the image
You can build the latest image by running:
```
docker build -t nextchain:3.5.0 ./3.5.0
```

## use latest image
If you rather want to work with an existing image (albeit in the example repo) then pull the 3.5.0 image from Dockerhub:
```
docker pull xaea12/nextchain:3.5.0
```

## contribute
I'd really appreciate it if we can fix the example repo so we can successfully interact with the RPC port! Feel free to submit PRs. This codebase is mostly inspired by the works of [docker-bitcoin](https://github.com/NicolasDorier/docker-bitcoin), check that out as well. 

