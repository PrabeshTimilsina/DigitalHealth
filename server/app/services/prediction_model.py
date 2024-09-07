import torch
from torchvision import models
from ..utils.image_processing import transform_image
from ..config import Config


model = models.inception_v3(
    num_classes=2,
    aux_logits=False
)
model.load_state_dict(torch.load(Config.MODEL_PATH, map_location=torch.device('cpu')))
model.eval()

def get_prediction(image_bytes):
    tensor = transform_image(image_bytes=image_bytes)
    output = model(tensor)
    _, predicted = torch.max(output, 1)
    return predicted


