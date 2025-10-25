Write-Host "Checking PyTorch GPU support..."
python -c "import torch; print('GPU Available:', torch.cuda.is_available()); print('Device:', torch.cuda.get_device_name(0))"
