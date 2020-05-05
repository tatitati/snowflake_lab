FROM ubuntu:18.04

ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

COPY ./docker-image/requirements.txt requirements.txt
COPY ./docker-image/terraform terraform

# Install python 3 + snowflake connectors
RUN apt-get update
RUN apt-get install -y python3.6 python3-pip wget unzip
RUN pip3 install --upgrade snowflake-connector-python
RUN pip3 install -r requirements.txt --no-index

# Install terraform
WORKDIR /tmp
RUN wget https://releases.hashicorp.com/terraform/0.12.18/terraform_0.12.18_linux_amd64.zip
RUN unzip terraform_0.12.18_linux_amd64.zip
RUN mv terraform /usr/local/bin/
