FROM pytorch/pytorch:1.13.1-cuda11.6-cudnn8-runtime

RUN apt-get update && apt-get install -yq --no-install-recommends \
    wget \
    bzip2 \
    ca-certificates \
    libglib2.0-0 \
    libxext6 \
    libsm6 \
    libxrender1 \
    git \
    vim \
    curl \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

USER root

RUN pip install jupyterlab pandas plotly wordcloud squarify streamlit stqdm transformers kiwipiepy matplotlib
RUN pip install transformers[sentencepiece]

ENV NVIDIA_VISIBLE_DEVICES=all \
    NVIDIA_DRIVER_CAPABILITIES=compute,utility \
    GRANT_SUDO=yes

WORKDIR /workspace

EXPOSE 8888

CMD ["jupyter", "lab", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--NotebookApp.token=''", "--allow-root"]