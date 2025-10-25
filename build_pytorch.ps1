# === PyTorch Build Script for RTX 50-Series ===
# Run in PowerShell as Administrator

# === CONFIG ===
$ROOT = "C:\PyTorchBuild"
$PYTORCH_REPO = "https://github.com/pytorch/pytorch.git"
$PYTORCH_DIR = "$ROOT\pytorch"
$CUDA_VERSION = "12.1"
$CUDA_ARCH = "12.0"  # sm_120
$LOG_FILE = "$ROOT\build_log_$(Get-Date -Format 'yyyyMMdd_HHmmss').txt"

# === STEP 1: Install Dependencies ===
Write-Host "`n[1/5] Installing dependencies..."
try {
    winget install --id Git.Git -e --silent
    winget install --id Kitware.CMake -e --silent
    winget install --id Python.Python.3.11 -e --silent
    winget install --id Microsoft.VisualStudio.2022.BuildTools -e --silent
} catch {
    Write-Host "Dependency install failed. Check winget availability."
}

# === STEP 2: Clone PyTorch ===
Write-Host "`n[2/5] Cloning PyTorch repo..."
if (-not (Test-Path $PYTORCH_DIR)) {
    git clone --recursive $PYTORCH_REPO $PYTORCH_DIR
    if (-not (Test-Path $PYTORCH_DIR)) {
        Write-Host "ERROR: PyTorch repo not found. Clone failed or path incorrect."
        exit
    }
} else {
    Write-Host "Repo already cloned. Skipping."
}

# === STEP 3: Set Environment Variables ===
Write-Host "`n[3/5] Setting build environment..."
$env:USE_CUDA = "1"
$env:TORCH_CUDA_ARCH_LIST = $CUDA_ARCH
$env:CUDA_HOME = "C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v$CUDA_VERSION"
$env:CMAKE_GENERATOR = "Visual Studio 17 2022"

# === STEP 4: Install Python Build Tools ===
Write-Host "`n[4/5] Installing Python packages..."
pip install --upgrade setuptools wheel
pip install numpy ninja pyyaml mkl mkl-include cmake cffi typing_extensions future six requests dataclasses

# === STEP 5: Build PyTorch ===
Write-Host "`n[5/5] Starting PyTorch build..."
cd $PYTORCH_DIR
python setup.py install *>&1 | Tee-Object -FilePath $LOG_FILE

Write-Host "`nBuild complete. PyTorch is now GPU-enabled for RTX 50-series."
Write-Host "Log saved to: $LOG_FILE"
Write-Host "Test with: .\extras\verify_gpu.ps1"
