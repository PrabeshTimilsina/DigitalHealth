import os

class Config:
    SECRET_KEY = os.urandom(24)
    MODEL_PATH = os.path.join(os.path.dirname(__file__), '../models/inceptionv3.pt')
    UPLOAD_FOLDER =os.path.join(os.path.dirname(__file__), '../images')
    GEMINI_APIKEY='AIzaSyB8P-DCar3EDNRGWnehGGCrruxQ1Simz-8'
    API_KEY = 'aepJopHqSnpM0LwZH3CPPiDa0d4TOHVo'
    API_URL = 'https://api.meersens.com/environment/public/uv/current'