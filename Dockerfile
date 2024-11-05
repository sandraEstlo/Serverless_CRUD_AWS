FROM ubuntu:20.04

ENV AWSCLI_VERSION=2.11.0

RUN apt-get update && \
    apt-get install -y \
    unzip \
    curl \
    && curl "https://awscli.amazonaws.com/AWSCLIV2.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    sudo ./aws/install && \
    rm awscliv2.zip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["aws"]