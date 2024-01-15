FROM python:3.9.5

# install git
RUN apt-get update && apt-get install --no-install-recommends --no-install-suggests -y curl

# Install Cytomine python client
RUN pip3 install git+https://github.com/cytomine/Cytomine-python-client.git@v2.3.3

# Install Stardist and tensorflow and its dependencies
# COPY requirements.txt /tmp/
# RUN pip3 install -r /tmp/requirements.txt
# RUN pip3 install stardist==0.8.2
RUN pip3 install sldc_cytomine
# RUN pip3 install tensorflow-gpu==2.8.0
# RUN pip3 install --upgrade charset-normalizer
# RUN pip3 install --upgrade stardist


# FROM nvidia/cuda:11.4.0-cudnn8-devel-ubuntu18.04
# CMD nvidia-smi

# RUN apt-get update && apt-get install --no-install-recommends --no-install-suggests -y curl
# RUN apt-get install unzip
# RUN apt-get -y install python3
# RUN apt-get -y install python3-pip
# # RUN --gpus all nvidia/cuda:11.4.0-base-ubuntu18.04 nvidia-smi

# FROM cytomine/software-python3-base:v2.2.0
# # Install Stardist and tensorflow
RUN pip3 install tensorflow-gpu==2.8.0
RUN pip3 install stardist==0.8.0
RUN pip3 install protobuf==3.20.*


# #INSTALL
# RUN pip3 install numpy==1.22.*
# RUN pip3 install shapely
# RUN pip3 install tifffile

WORKDIR /models
RUN mkdir -p 2D_versatile_fluo_sish
ADD /models/2D_versatile_fluo_sish/config.json /models/2D_versatile_fluo_sish/config.json
ADD /models/2D_versatile_fluo_sish/thresholds.json /models/2D_versatile_fluo_sish/thresholds.json
ADD /models/2D_versatile_fluo_sish/weights_best.h5 /models/2D_versatile_fluo_sish/weights_best.h5
RUN chmod 444 /models/2D_versatile_fluo_sish/config.json
RUN chmod 444 /models/2D_versatile_fluo_sish/thresholds.json
RUN chmod 444 /models/2D_versatile_fluo_sish/weights_best.h5

# --------------------------------------------------------------------------------------------
#ADD FILES
RUN mkdir -p /app
ADD descriptor.json /app/descriptor.json
ADD run.py /app/run.py

ENTRYPOINT ["python3", "/app/run.py"]
