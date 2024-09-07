from flask import request, jsonify
import requests
from app import app
from .config import Config
import os
from app.services.prediction_model import get_prediction
from app.services.text_extraction_model import extract_text

from app.services.summarize_report import summarize_text
@app.route('/')
def test():
    return 'Hello, this is the Prediction backend.'

@app.route('/predict', methods=['POST'])
def predict():
    if request.method == 'POST':
        file = request.files['file']
        img_bytes = file.read()
        value = get_prediction(image_bytes=img_bytes)
        result=''
        if(value.item()==1):
            result="Malignant"
        else:
            result='Bening'
        return jsonify({'prediction': value.item(),'result':result})


@app.route('/extracttext',methods=['POST'])
def extractText():
    if request.method=='POST':
        file = request.files['file']
        upload_path=os.path.join(app.config['UPLOAD_FOLDER'], file.filename)
        file.save(upload_path)
        paragraph=extract_text(upload_path)
        # infromation=extract_infromation('NAME',paragraph)
        summarized_text=summarize_text(paragraph)
        
        return jsonify({
            'Report Pargraph':paragraph,
            "Summarize_text":summarized_text
        })
        


API_KEY = Config.API_KEY
API_URL = Config.API_URL

@app.route('/uv', methods=['GET'])
def get_uv_data():
    lat = request.args.get('lat')
    lng = request.args.get('lng')
    
    if not lat or not lng:
        return jsonify({'error': 'Please provide both lat and lng parameters'}), 400
    
    try:
        # Make the request to Meersens API
        response = requests.get(API_URL, headers={
            'apikey': API_KEY
        }, params={
            'lat': lat,
            'lng': lng
        })
        
        # Log the response content for debugging
        print(response.text)
        
        # If the response is successful, return the data
        if response.status_code == 200:
            return jsonify(response.json()), 200
        else:
            return jsonify({
                'error': 'Failed to fetch data from Meersens API',
                'message': response.text  # Include the API's error message
            }), response.status_code
    except Exception as e:
        return jsonify({'error': str(e)}), 500