#!/usr/bin/env bash
APP="openvscode-julia-cuda"

JULIA_VERSION=$(curl -sL https://julialang.org/downloads/ \
      | sed 's|.*Current stable release: v||' \
      | sed 's| (.*||')

CODE_VERSION=$(curl -sX GET "https://api.github.com/repos/gitpod-io/openvscode-server/releases/latest" \
      | awk '/tag_name/{print $4;exit}' FS='[""]' \
      | sed 's|^openvscode-server-v||')

CUDA_VERSION=$(curl -sL https://gitlab.com/nvidia/container-images/cuda/-/raw/master/doc/supported-tags.md \
      | grep 'cudnn8-devel-ubuntu20.04' \
      | sed -n "s/\([-\` \[]*\)\([-0-9.a-z]*\).*/\2/p" \
      | sort | tail -n1)

# set multiple version in dockerfile
sed -e "s/%%CUDA_VERSION%%/${CUDA_VERSION}/g; \
        s/%%CODE_VERSION%%/${CODE_VERSION}/g; \
        s/%%JULIA_VERSION%%/${JULIA_VERSION}/g" ./apps/${APP}/assets/Dockerfile.template > ./apps/${APP}/Dockerfile

sed -e "s/%%JULIA_VERSION%%/${JULIA_VERSION}/g" ./apps/${APP}/assets/Project.toml.template > ./apps/${APP}/Project.toml

printf "%s" "${CUDA_VERSION}-${JULIA_VERSION}-${CODE_VERSION}"