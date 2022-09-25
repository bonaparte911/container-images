#!/usr/bin/env bash

# run in root-folder: APP=openvscode-julia-cuda && bash "./apps/${APP}/buildx.sh"

APP=openvscode-julia-cuda
bash "./apps/${APP}/latest-version.sh" > ./apps/${APP}/VERSION
VERSION=$(cat ./apps/${APP}/VERSION)

docker run --rm -i hadolint/hadolint <  "./apps/${APP}/Dockerfile"

docker buildx build --build-arg "VERSION=${VERSION}" --file "./apps/${APP}/Dockerfile" --platform "linux/amd64" --tag "ghcr.io/bonaparte911/openvscode-julia-cuda:latest" --tag "ghcr.io/bonaparte911/openvscode-julia-cuda:${VERSION}" .


