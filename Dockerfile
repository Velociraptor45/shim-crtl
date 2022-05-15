FROM balenalib/rpi-raspbian

RUN apt-get update
RUN apt-get install -y git python3-pip gcc python3-rpi.gpio lsb-release
RUN pip3 install setuptools
RUN apt-get clean all

RUN git clone https://github.com/pimoroni/fanshim-python
RUN fanshim-python/install.sh
RUN mkdir /app
RUN cp -a fanshim-python/examples/install-service.sh /app/install-service.sh
RUN rm -rf fanshim-python

ENV PATH="/app:${PATH}"
COPY ./startup.sh /app/startup.sh
RUN chmod +x /app/startup.sh

WORKDIR /app
ENTRYPOINT ["startup.sh"]
