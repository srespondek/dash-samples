from python:3.7-buster

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

ENV PATH=/opt/conda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN apt-get update --fix-missing &&     apt-get install -y wget bzip2 ca-certificates libglib2.0-0 libxext6 libsm6 libxrender1 git mercurial subversion &&     apt-get clean

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh &&     /bin/bash ~/miniconda.sh -b -p /opt/conda &&     rm ~/miniconda.sh &&     /opt/conda/bin/conda clean -tipsy &&     ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh &&     echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc &&     echo "conda activate base" >> ~/.bashrc &&     find /opt/conda/ -follow -type f -name '*.a' -delete &&     find /opt/conda/ -follow -type f -name '*.js.map' -delete &&     /opt/conda/bin/conda clean -afy

RUN apt-get install -y curl vim-tiny vim-athena jq

COPY /dash-drug-discovery /dash-drug-discovery

WORKDIR /dash-drug-discovery

RUN pip3.7 install -r requirements.txt

CMD ["sh", "-c", "python3.7 app.py"]

