FROM jupyter/scipy-notebook

USER root
RUN apt-get update
RUN apt-get install -y default-jre
USER jovyan
WORKDIR /home/jovyan/work


RUN mkdir mount
RUN mkdir openworm
ENV OPENWORM_HOME /home/jovyan/work/openworm

WORKDIR $OPENWORM_HOME
RUN wget http://github.com/openworm/ChannelWorm/tarball/sciunit -O out.tar.gz
RUN mkdir ChannelWorm
RUN tar -xvzf out.tar.gz --strip-components=1 -C ChannelWorm
WORKDIR ChannelWorm
RUN pip install -e . --process-dependency-links

WORKDIR $OPENWORM_HOME
RUN wget http://github.com/openworm/CElegansNeuroML/tarball/sciunit -O out.tar.gz
RUN mkdir CElegansNeuroML
RUN tar -xvzf out.tar.gz --strip-components=1 -C CElegansNeuroML
WORKDIR CElegansNeuroML
RUN pip install -e . --process-dependency-links
RUN pip install quantities sciunit django
WORKDIR $OPENWORM_HOME
RUN git clone http://github.com/openworm/tests
WORKDIR tests

RUN pip install -e . --process-dependency-links
RUN python -m unittest -b owtests

#RUN pip install -e .[channels,cells] --process-dependency-links


RUN git clone -b dev https://github.com/russelljjarvis/neuronunit
RUN ls -ltr
RUN ls neuronunit/neuronunit/tests/dynamics.py
RUN mv neuronunit/neuronunit/tests/dynamics.py /opt/conda/lib/python3.6/site-packages/neuronunit/tests/dynamics.py

WORKDIR $OPENWORM_HOME
RUN git clone https://github.com/rgerkin/tracker-commons
WORKDIR tracker-commons
RUN git pull origin master
WORKDIR /home/jovyan/work
