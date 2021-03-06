FROM jupyter/base-notebook

USER root

RUN apt-get update

RUN apt-get install -y build-essential wget git python python-pip virtualenv

RUN python2.7 -m pip install -U --force-reinstall pip

RUN wget https://github.com/nxadm/rakudo-pkg/releases/download/v2018.01/rakudo-pkg-Ubuntu17.10_2018.01-01_amd64.deb

RUN dpkg -i *.deb && rm *.deb

RUN wget https://github.com/zeromq/libzmq/releases/download/v4.2.2/zeromq-4.2.2.tar.gz && \
        tar -xzvf zeromq-4.2.2.tar.gz && \
        cd zeromq-4.2.2 && ./configure --prefix=/usr && make && make install && cd .. && rm -rf zeromq*

RUN /sbin/ldconfig

RUN chown -R $NB_USER /usr/local

USER $NB_USER

ENV PATH="${HOME}/.perl6/bin:/usr/share/perl6/site/bin:/opt/rakudo-pkg/bin:${PATH}"

RUN install-zef-as-user

RUN git clone https://github.com/bduggan/p6-jupyter-kernel.git && cd p6-jupyter-kernel && zef install --/test .

RUN zef install JSON::Fast

RUN jupyter-kernel.p6 --generate-config

RUN date > build-date

RUN git clone https://github.com/bduggan/p60j

RUN cd p60j && python2.7 -m pip install -r requirements.txt  \
        && pip install RISE \
        && jupyter-nbextension install rise --py --sys-prefix \
        && jupyter-nbextension enable rise --py --sys-prefix
