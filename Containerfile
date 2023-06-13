FROM fedora:38

RUN dnf -y update

RUN dnf -y install \
        python3-pip \
        git

ADD requirements.txt /

RUN pip install -r /requirements.txt

CMD python3 -m jupyterlab
