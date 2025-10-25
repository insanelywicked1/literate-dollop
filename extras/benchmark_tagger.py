import torch, time
from torchvision import models

device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
model = models.resnet50(pretrained=True).to(device)
model.eval()

dummy_input = torch.randn(32, 3, 224, 224).to(device)

start = time.time()
with torch.no_grad():
    for _ in range(10):
        _ = model(dummy_input)
end = time.time()

print(f"Inference time (10x batch of 32): {end - start:.2f} seconds")
