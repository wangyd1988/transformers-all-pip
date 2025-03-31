FROM python:3.9-slim AS builder

RUN apt update && apt install -y git libsndfile1-dev tesseract-ocr espeak-ng ffmpeg git-lfs \
    && rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install --no-cache-dir --upgrade pip
RUN python3 -m pip install --no-cache-dir transformers

# 使用 python:3.9-slim 作为最终镜像
FROM python:3.9-slim AS runtime

COPY --from=builder /usr/local/lib/python3.9 /usr/local/lib/python3.9
COPY --from=builder /usr/local/bin /usr/local/bin

ENTRYPOINT ["python3"]
