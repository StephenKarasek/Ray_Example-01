#   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #
# Base:                 Grab image from source
#   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #
#FROM python:3.9.13-alpine3.16 as base
#FROM public.ecr.aws/docker/library/python:3.10 as base
#FROM public.ecr.aws/docker/library/python:3.9 as base

#   *   *   *   *   *   *   *   *
# NVidia Image
#   -   -   -   -
# 12.1.0
#FROM nvidia/cuda:12.1.0-base-ubuntu22.04 as base
FROM nvidia/cuda:12.1.0-runtime-ubuntu22.04 as base

#FROM nvidia/cuda:12.1.0-base-ubuntu20.04 as base
#FROM nvidia/cuda:12.1.0-devel-ubuntu20.04 as base
#FROM nvidia/cuda:12.1.0-runtime-ubuntu20.04 as base
#FROM nvidia/cuda:12.1.0-cudnn8-base-ubuntu20.04 as base
#FROM nvidia/cuda:12.1.0-cudnn8-devel-ubuntu20.04 as base
#FROM nvidia/cuda:12.1.0-cudnn8-runtime-ubuntu20.04 as base
#   .   .   .   .
# 12.3.1
# FROM nvidia/cuda:12.3.1-devel-ubuntu20.04 as base
# FROM nvidia/cuda:12.3.1-runtime-ubuntu20.04 as base
# FROM nvidia/cuda:12.3.1-base-ubuntu20.04 as base
# FROM nvidia/cuda:12.3.1-cudnn8-devel-ubuntu20.04 as base
# FROM nvidia/cuda:12.3.1-cudnn8-runtime-ubuntu20.04 as base
# FROM nvidia/cuda:12.3.1-cudnn8-base-ubuntu20.04 as base
#   .   .   .   .
# 11.6.1
# FROM nvidia/cuda:11.6.1-runtime-ubuntu20.04 as base
# FROM pull nvidia/cuda:11.6.1-devel-ubuntu20.04 as base
# FROM nvidia/cuda:11.6.1-cudnn8-runtime-ubuntu20.04 as base
# FROM nvidia/cuda:11.6.1-cudnn8-devel-ubuntu20.04 as base
#FROM nvcr.io/nvidia/cloud-native/k8s-driver-manager:v0.6.5-ubi8 as base


ENV DEBIAN_FRONTEND noninteractive
#RUN DEBIAN_FRONTEND=noninteractive apt-get install -y ...

#   *   *   *   *   *   *   *   *
# Grab Mistral image
#   -   -   -   -
#FROM ghcr.io/mistralai/harmattan/vllm-public:latest as base


# Set the working directory within the container
ARG WORKDIR="/app"
ENV WORKDIR=${WORKDIR}
WORKDIR ${WORKDIR}



#   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #
# Install (core):       install fundamental packages
#   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #
FROM base as install-core

#   *   *   *   *   *   *   *   *
# Essential Installs
#   -   -   -   -
RUN apt-get update \
    && apt-get install --no-install-recommends -y \
    build-essential gcc build-essential coreutils curl git wget \
    python3.10-dev python3-pip nvidia-container-toolkit \
    && apt-get clean && rm -rf /var/lib/apt/lists/*


#   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #
# Install (env):        install pytorch
#   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #
FROM install-core as install-env

#   -   -   -   -
# Version = 12.1
RUN pip install -U torch --index-url https://download.pytorch.org/whl/cu121

#   *   *   *   *   *   *   *   *
# Ray install
#   -   -   -   -
RUN pip install -U "ray[serve]"
#RUN pip install -U "ray[data,train,tune,serve]"



#   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #
# Requirements Stage:   []
#   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #
FROM install-env as requirements
#
COPY requirements.txt ${WORKDIR}/.

#   *   *   *   *   *   *   *   *
# Install Requirements
#   -   -   -   -

#   .   .   .   .
# Install Python dependencies from the requirements file
RUN pip install --no-cache-dir -r requirements.txt




#   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #
# Code Stage:           []
FROM requirements as code
#
# Copy source code
COPY /src ${WORKDIR}/.
COPY build.sh .


#   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #
# Execution Stage:      []
FROM code as execute
# Ports
EXPOSE 8000

#   *   *   *   *   *   *   *   *
# Entrypoint
#   -   -   -   -
#ENTRYPOINT [ "PYTHON_VENV" ]
ENTRYPOINT [ "python" ]

#   *   *   *   *   *   *   *   *
# Run
#   -   -   -   -
CMD [ "hello_world.py" ]

