FROM jupyter/base-notebook

USER root

RUN apt-get update

RUN apt-get install -y build-essential

RUN apt-get install wget

RUN wget https://github.com/nxadm/rakudo-pkg/releases/download/v2018.01/rakudo-pkg-Ubuntu17.10_2018.01-01_i386.deb

RUN dpkg -i *.deb

USER $NB_USER

ENV PATH /usr/share/perl6/site/bin:/opt/rakudo/bin:$PATH

RUN install-zef-as-user

RUN zef -v install https://github.com/bduggan/p6-jupyter-kernel.git@0.0.7 && jupyter-kernel.p6 --generate-config

RUN git clone https://github.com/bduggan/p60j && cd p60j && pip install -r requirements.txt

