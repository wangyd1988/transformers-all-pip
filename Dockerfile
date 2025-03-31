#FROM nvidia/cuda:12.1.0-cudnn8-devel-ubuntu22.04
FROM  python:3.9-slim  AS builder

# The following `ARG` are mainly used to specify the versions explicitly & directly in this docker file, and not meant
# to be used as arguments for docker build (so far).

RUN apt update
#RUN apt install -y git libsndfile1-dev tesseract-ocr espeak-ng python3 python3-pip ffmpeg git-lfs
#RUN git lfs install
RUN python3 -m pip install --no-cache-dir --upgrade pip

# RUN python3 -m pip install --no-cache-dir transformers torch fastapi uvicorn 

# RUN python3 -m pip install --no-cache-dir json datetime re 
RUN python3 -m pip install --no-cache-dir transformers

FROM docker.io/library/busybox:latest
COPY --from=builder /usr/local/lib/python3.9/dist-packages  /bin

COPY --from=builder /usr/local/bin /bin

