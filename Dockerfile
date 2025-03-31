# 第一阶段：构建 Python 依赖
FROM python:3.9-slim AS builder

RUN apt update && apt install -y git libsndfile1-dev tesseract-ocr espeak-ng ffmpeg git-lfs \
    && rm -rf /var/lib/apt/lists/*

RUN python3 -m pip install --no-cache-dir --upgrade pip
RUN python3 -m pip install --no-cache-dir transformers

# 第二阶段：构建精简的最终镜像
FROM python:3.9-alpine AS runtime

# 复制 Python 依赖
COPY --from=builder /usr/local/lib/python3.9 /usr/local/lib/python3.9
COPY --from=builder /usr/local/bin /usr/local/bin

# 运行时环境
ENTRYPOINT ["python3"]
