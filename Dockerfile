FROM python:3.10-slim
RUN python3 -m pip install --no-cache-dir transformers torch fastapi uvicorn 
