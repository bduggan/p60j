FROM jupyter/base-notebook

USER root

RUN apt-get update

RUN apt-get install -y build-essential wget git python python-pip virtualenv

RUN wget https://github.com/nxadm/rakudo-pkg/releases/download/v2018.01/rakudo-pkg-Ubuntu17.10_2018.01-01_amd64.deb

RUN dpkg -i *.deb

RUN wget https://github.com/zeromq/libzmq/releases/download/v4.2.2/zeromq-4.2.2.tar.gz && \
        tar -xzvf zeromq-4.2.2.tar.gz && \
        cd zeromq-4.2.2 && ./configure --prefix=/usr && make && make install && cd ..

RUN /sbin/ldconfig

USER $NB_USER

ENV PATH="${HOME}/.perl6/bin:/usr/share/perl6/site/bin:/opt/rakudo-pkg/bin:${PATH}"

RUN install-zef-as-user

RUN git clone https://github.com/bduggan/p6-jupyter-kernel.git && cd p6-jupyter-kernel && zef install --/test .

RUN jupyter-kernel.p6 --generate-config

RUN git clone https://github.com/bduggan/p60j

RUN cd p60j && virtualenv venv && . ./venv/bin/activate

RUN cd p60j && pip install -r requirements.txt
