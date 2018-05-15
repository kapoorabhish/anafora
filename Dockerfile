FROM ubuntu:16.04

RUN apt-get update && \
    apt-get upgrade -y && \ 
    apt-get install -y \
	git \
	python \
	python-dev \
	python-setuptools \
	python-pip \
	nginx \
	supervisor &&\
	pip install -U pip setuptools && \
  	rm -rf /var/lib/apt/lists/*

RUN echo "daemon off;" >> /etc/nginx/nginx.conf
COPY nginx.conf /etc/nginx/sites-available/default
COPY supervisor.conf /etc/supervisor/conf.d/
COPY uwsgi.ini /home/docker/uwsgi.ini
COPY entrypoint.sh /home/docker/entrypoint.sh
COPY requirements.txt /home/docker/
COPY src /home/docker/

RUN pip install -r /home/docker/requirements.txt
