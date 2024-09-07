import torch
from torchvision  import models
from ..utils.image_processing import transform_image
from ..config import Config
from PIL import Image
import torchvision.transforms as transforms
from torchvision.transforms.functional import InterpolationMode

interpolation = InterpolationMode.BILINEAR
val_crop_size = 224
global val_resize_size
val_resize_size= 224

def get_prediction(image_path):
    model = models.inception_v3(init_weights=True)
    state_dict = torch.load('./models/inceptionv3.pt',map_location=torch.device('cpu'),weights_only=True)

     
    num_ftrs = model.fc.in_features
    model.fc = torch.nn.Linear(num_ftrs, 2) 
    model.load_state_dict(state_dict,strict=False)

    val_resize_size = 299
    
    model.eval()
    TRANSFORM_IMG = transforms.Compose([
    transforms.Resize(val_resize_size, interpolation=interpolation),
    transforms.CenterCrop(val_crop_size),
    transforms.PILToTensor(),
    transforms.ConvertImageDtype(torch.float),
    transforms.Normalize(mean=[0.485, 0.456, 0.406],
                            std=[0.229, 0.224, 0.225] )])

        # load image
    image_not_transformed = Image.open(image_path).convert('RGB')

        # transforming the image
    image = TRANSFORM_IMG(image_not_transformed).unsqueeze(0).to('cpu') 
    outputs = model(image)
    
    _, predicted = torch.max(outputs, 1)
    
   
    
    return predicted


