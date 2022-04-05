FROM cytomine/software-python3-base:v2.2.0

# -----------------------------------------------------------------------------
# Install Stardist and tensorflow
RUN pip install tensorflow==2.8.0
RUN pip install stardist==0.8.0
RUN mkdir -p /models && \
    cd /models && \
    mkdir -p 2D_versatile_HE
ADD config.json /models/2D_versatile_HE/config.json
ADD thresholds.json /models/2D_versatile_HE/thresholds.json
ADD weights_best.h5 /models/2D_versatile_HE/weights_best.h5
RUN chmod 444 /models/2D_versatile_HE/config.json
RUN chmod 444 /models/2D_versatile_HE/thresholds.json
RUN chmod 444 /models/2D_versatile_HE/weights_best.h5


# --------------------------------------------------------------------------------------------
# Install scripts
ADD descriptor.json /app/descriptor.json
RUN mkdir -p /app
ADD run.py /app/run.py

ENTRYPOINT ["python3", "/app/run.py"]

