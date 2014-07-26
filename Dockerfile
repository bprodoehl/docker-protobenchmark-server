# Protocol Benchmarking Server
#
# VERSION               0.0.1

FROM      phusion/baseimage:0.9.12
MAINTAINER Connectify <bprodoehl@connectify.me>

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

EXPOSE 80

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# install dependencies
RUN apt-get update && apt-get install -y nginx wget python python-imaging \
                                         python-numpy

# generate test files
ADD files/mk-data.sh /tmp/mk-data.sh
ADD files/generate-images.py /tmp/generate-images.py
WORKDIR /tmp
RUN ./mk-data.sh

ADD files/test /usr/share/nginx/html/test

### Configure runit
RUN mkdir /etc/service/nginx
ADD runit/nginx.sh /etc/service/nginx/run

ADD config/nginx.conf /etc/nginx/nginx.conf

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
