# PYPY 3.7 (V7.3.3) on a Debian 10 Base.
#FROM pypy:3.7-7.3.4-buster
#FROM python:3.7.10-buster
FROM python:3.8-buster

LABEL maintainer="Steven Johnson <sakurainds@gmail.com>"

# Create with the following options:
# --tmpfs /tmp - Ram based tmpfs on tmp
WORKDIR /build

# Install Necessary System Libraries
RUN apt-get update &&\
    apt-get install --upgrade -y &&\
    apt-get install -y \
    gcc \
    gfortran \
    python-dev \
    cython \
    rsync

# Install Python requirements.
COPY requirements.txt .
RUN pip install --upgrade pip setuptools wheel
RUN pip install -r requirements.txt

# COPY the run script into the container.
COPY *.py ./

COPY run_test.sh .

# Port we expose internally - A range so i can add science experiments to different
# ports.
EXPOSE 7000-7999

# turn off python output buffering
ENV PYTHONUNBUFFERED=1

ENTRYPOINT ["bash", "./run_test.sh"]

