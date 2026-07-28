# Docker Multi-stage vs Single-stage Build Guide

This directory contains a simple Python Flask application and two Dockerfiles to compare **Single-stage** vs **Multi-stage** Docker builds.

## Directory Structure

```
docker/
├── app.py
├── requirements.txt
├── Dockerfile.single   # Standard single-stage Dockerfile
├── Dockerfile.multi    # Optimized multi-stage Dockerfile
└── README.md
```

---

## 1. Single-Stage Docker Build (Without Multi-Stage)

In a single-stage build, build tools, cache, compilers, and all intermediate files remain inside the final Docker image.

### Step 1: Build the image
```bash
docker build -f Dockerfile.single -t python-app:single .
```

### Step 2: Run the container
```bash
docker run -d -p 5001:5000 --name app-single python-app:single
```

### Step 3: Test the application
```bash
curl http://localhost:5001
```

---

## 2. Multi-Stage Docker Build (With Multi-Stage)

In a multi-stage build:
- **Stage 1 (`builder`)**: Uses full base image to download packages and build virtual environments.
- **Stage 2 (`runner`)**: Copies **only** the compiled virtualenv and app files into a slim runtime image.

### Step 1: Build the image
```bash
docker build -f Dockerfile.multi -t python-app:multi .
```

### Step 2: Run the container
```bash
docker run -d -p 5002:5000 --name app-multi python-app:multi
```

### Step 3: Test the application
```bash
curl http://localhost:5002
```

---

## 3. Comparing Image Sizes & Cleaning Up

### Compare Image Sizes
Run this command to see the size difference between the single-stage and multi-stage images:
```bash
docker images | grep python-app
```

### Stop & Remove Containers
```bash
docker stop app-single app-multi
docker rm app-single app-multi
```

### Key Differences Summary

| Feature | Single-Stage (`Dockerfile.single`) | Multi-Stage (`Dockerfile.multi`) |
|---|---|---|
| **Base Image** | `python:3.11` (full) | `python:3.11` -> `python:3.11-slim` |
| **Image Size** | Larger (~1 GB) | Much Smaller (~150-200 MB) |
| **Security** | Contains build compilers & runs as `root` | No build tools & runs as non-root user (`appuser`) |
| **Use Case** | Quick dev/testing | Production deployments |
