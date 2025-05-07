FROM quay.io/fedora/fedora:42

RUN dnf -y update

RUN dnf -y install \
        python3-pip \
        git

ADD requirements.txt /

RUN pip install -r /requirements.txt

# Add custom stuff to the container
WORKDIR /opt
ADD scripts/00_*.sh /scripts/
RUN bash /scripts/00_*.sh
ADD scripts/01_*.sh /scripts/
RUN bash /scripts/01_*.sh
ADD scripts/02_*.sh /scripts/
RUN bash /scripts/02_*.sh
ADD scripts/03_*.sh /scripts/
RUN bash /scripts/03_*.sh
ADD scripts/04_*.sh /scripts/
RUN bash /scripts/04_*.sh
ADD scripts/05_*.sh /scripts/
RUN bash /scripts/05_*.sh
ADD scripts/06_*.sh /scripts/
RUN bash /scripts/06_*.sh

CMD python3 -m jupyterlab
