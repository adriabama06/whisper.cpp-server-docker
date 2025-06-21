# whisper.cpp-server-docker  

Quickly deploy an OpenAI Whisper server using Docker & Docker Compose.  

## 📥 Download a Model  

Download a model from [Hugging Face](https://huggingface.co/ggerganov/whisper.cpp/tree/main).  
For example, you can use `ggml-large-v3-turbo.bin`.  

## ⚡ Quantize the Model (Optional)  

If you want to quantize the model, follow these steps:  

1️⃣ **Build the Docker image:**  

```bash
docker build -f Dockerfile . -t whisper:cpu
```

Or use Docker Compose:  

```bash
docker compose -f compose.whatyouwant.yml up -d
```

2️⃣ **Run the quantization process:**  

```bash
docker run -it --rm \
  -v ./ggml-large-v3-turbo.bin:/model.bin \
  -v ./models:/models \
  whisper:cpu \
  ./build/bin/quantize /model.bin /models/ggml-large-v3-turbo_q8.bin q8_0
```

After this, the `models` folder will contain the quantized model:  
📂 `models/ggml-large-v3-turbo_q8.bin`  

## 🚀 Running the Server  

### 🖥️ CPU  

To run the server using the CPU:  

```bash
WHISPER_MODEL_PATH=./models/ggml-large-v3-turbo_q8.bin \
docker compose -f compose.yml up -d
```

### ⚡ CUDA (NVIDIA GPUs)  

> **⚠️ Note:** This version did not work on my computer. If you get it running, please open an issue!  

```bash
WHISPER_MODEL_PATH=./models/ggml-large-v3-turbo_q8.bin \
docker compose -f compose.cuda.yml up -d
```

### 🔥 ROCm (AMD GPUs)  

> ⚠️ Use `rocminfo | grep gfx` to know your AMDGPU_TARGETS and HSA_OVERRIDE_GFX_VERSION

```bash
WHISPER_MODEL_PATH=./models/ggml-large-v3-turbo_q8.bin \
AMDGPU_TARGETS=gfx1030 \
HSA_OVERRIDE_GFX_VERSION='10.3.0' \
docker compose -f compose.rocm.yml up -d
```

## 🌐 Changing the Port  

By default, the server runs on port **9001**. To change the port, set the `PORT` variable before starting the container:  

```bash
WHISPER_MODEL_PATH=./models/ggml-large-v3-turbo_q8.bin \
PORT=8080 \
docker compose -f compose.yml up -d
```

## ✅ Testing the Server  

Run a test script using either Node.js or Python:  

```bash
node run_example.js
```  
or  

```bash
python run_example.py
```  
