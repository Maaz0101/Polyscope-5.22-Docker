# Polyscope 5.22 Docker Container

A Dockerized environment to run **Polyscope 5.22** with VNC and browser-based access.  
This image was built **from scratch** using a custom Dockerfile to provide a clean, reproducible, and portable setup for development, testing, and academic demonstrations.

---

## Overview

Polyscope is the graphical user interface (GUI) and operating environment used by Universal Robots.  
This project packages **Polyscope 5.22** inside a Docker container, making it possible to run the full environment without requiring installation on a physical robot or a complex local setup.

The container is designed to be:
- **Lightweight** – runs anywhere Docker is supported.  
- **Accessible** – connect via VNC or a standard web browser.  
- **Extensible** – mount local folders to add custom URCaps, scripts, or robot programs.  

---

## Features

- **Polyscope 5.22** (latest stable release).  
- Access via **web browser** (`http://localhost:6080/vnc_auto.html`).  
- Optional access via **VNC client** (`localhost:5900`).  
- Fully reproducible environment with no extra dependencies required.  
- Supports custom programs and URCaps through volume mounting.  

---

## Requirements

- [Docker](https://www.docker.com/) installed (recommended version ≥ 20.10).  
- No additional software needed.  

---

## How to Use

### 1. Clone this repository

```bash
git clone https://github.com/Maaz0101/Polyscope-5.22-Docker.git
cd Polyscope-5.22-Docker
```

### 2. Build the Docker image

```bash
docker build -t polyscope-5.22 .
```

### 2. Run the container

```bash
docker run --rm -it -p 5900:5900 -p 6080:6080 \
  --name polyscope-5.22 \
  polyscope-5.22
```

### 3. Access the GUI
With any VNC client like [Real VNC](https://www.realvnc.com/) connect to `localhost:5900`

## License

This project and the Dockerfile were created by Maaz0101 and are provided **for educational and research purposes only**.

- The Polyscope software contained in this image is **proprietary** and remains the intellectual property of **Universal Robots A/S**. This repository **does not** grant any license to Polyscope itself; users must comply with Universal Robots' licensing terms and end-user agreements.
- You are free to use, inspect, and adapt the Dockerfile and accompanying scripts for non-commercial, academic, and development purposes. Redistribution that includes Polyscope binaries or any other proprietary Universal Robots files is **strictly prohibited** unless you have explicit permission from Universal Robots.
- **No warranty.** This project is provided "AS IS", without warranty of any kind, express or implied. The author(s) are not liable for any damages or losses arising from the use of this software or container.

If you wish to apply an open-source license to the non-proprietary code in this repository (i.e., the Dockerfile, scripts, and documentation), consider adding a standard license file (e.g., MIT, Apache-2.0). For any commercial use or redistribution that involves Polyscope, obtain explicit permission from Universal Robots.
