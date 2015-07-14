FROM ubuntu:latest
ENV PATH_SRV /srv
ENV PATH_DATA /data
ENV DEBIAN_FRONTEND noninteractive
MAINTAINER "Christian Sakshaug" <christian@comunic.no>
RUN mkdir -p $PATH_SRV
RUN mkdir -p $PATH_DATA
WORKDIR $PATH_SRV
ADD . $PATH_SRV
ADD .env.example $PATH_DATA/.env
RUN ln -s $PATH_DATA/.env $PATH_SRV/.env
RUN chmod 0755 $PATH_SRV/run-build
RUN $PATH_SRV/run-build
RUN rm run-build
VOLUME $PATH_SRV
CMD ["true"]