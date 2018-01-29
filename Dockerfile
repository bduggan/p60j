FROM jupyter/base-notebook

USER root

RUN apt-get update

RUN apt-get install -y build-essential wget git

RUN wget https://github.com/nxadm/rakudo-pkg/releases/download/v2018.01/rakudo-pkg-Ubuntu17.10_2018.01-01_amd64.deb

RUN dpkg -i *.deb

USER $NB_USER

ENV PATH /usr/share/perl6/site/bin:/opt/rakudo-pkg/bin:~/.perl6/bin:$PATH

RUN  wget https://github.com/zeromq/libzmq/releases/download/v4.2.2/zeromq-4.2.2.tar.gz && \
        tar -xzvf zeromq-4.2.2.tar.gz && \
        cd zeromq-4.2.2 && ./configure --prefix=/usr && make && sudo make install && cd ..

RUN /sbin/ldconfig

RUN install-zef-as-user

RUN git clone https://github.com/bduggan/p6-jupyter-kernel.git && cd p6-jupyter-kernel && zef install .

RUN jupyter-kernel.p6 --generate-config

RUN git clone https://github.com/bduggan/p60j && cd p60j && pip install -r requirements.txt

