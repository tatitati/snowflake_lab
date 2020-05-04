FROM ubuntu:18.04

ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8


RUN apt-get update
RUN apt-get install -y python3.6 python3-pip
RUN pip3 install --upgrade snowflake-connector-python

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt --no-index
