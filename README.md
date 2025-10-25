# literate-dollop
A fully automated PowerShell script to compile PyTorch from source with CUDA 12.1 support for NVIDIA RTX 50-series GPUs, optimized for Windows 11.
# PyTorch RTX 50-Series GPU Build Script

This project provides a fully automated PowerShell script to compile PyTorch from source with full CUDA 12.1 support for NVIDIA RTX 50-series GPUs (Blackwell architecture, `sm_120`).

## ✅ Supported GPUs
- RTX 5090, 5080, 5070 Ti, 5070, 5060 Ti, 5060, 5050
- Any GPU with CUDA Compute Capability 12.0+

## 🧰 Requirements
- Windows 11
- Admin PowerShell
- CUDA 12.1 Toolkit installed
- Git, Python 3.11, CMake, Visual Studio 2022 Build Tools (auto-installed)

## 🚀 Quick Start

1. Clone this repo or download the ZIP
2. Open PowerShell as Administrator
3. Run the script:
   ```powershell
   Set-ExecutionPolicy RemoteSigned -Scope Process
   .\build_pytorch.ps1
