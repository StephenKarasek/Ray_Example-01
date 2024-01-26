#   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #
# Base Image:       Ray
#FROM rayproject/ray:latest as base
FROM rayproject/ray:2.5.0 as base
#FROM rayproject/ray-ml:latest

# Grab Mistral image
#FROM ghcr.io/mistralai/harmattan/vllm-public:latest as base


#
# Set the working directory within the container
ARG WORKDIR="/app"
ENV WORKDIR=${WORKDIR}
WORKDIR ${WORKDIR}


#   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #
# Application Stage: Copy application files and set up the environment
FROM base as install
ARG WORKDIR="/app"
RUN sudo apt-get update && \
    apt-get install --no-install-recommends -y python3.10 && \
    apt-get install --no-install-recommends -y python3-pip && \
    apt-get install --no-install-recommends -y python3-venv && \
    apt-get install --no-install-recommends -y build-essential

#apt-get install --no-install-recommends -y git && \


#   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #
# Application Stage: Copy application files and set up the environment
FROM install as requirements
#
COPY requirements.txt ${WORKDIR}/.
RUN pip install --no-cache-dir -r requirements.txt


#   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #   #
# Application Stage: Copy application files and set up the environment
FROM requirements as code
#
EXPOSE 8000
ENTRYPOINT [ "python3" ]
CMD [ "textbot.py" ]

#RUN --gpus all -e HF_TOKEN=$HF_TOKEN -p 8000:8000 ghcr.io/mistralai/harmattan/vllm-public:latest --host 0.0.0.0 --model mistralai/Mistral-7B-v0.1
