from flask import request, jsonify
import requests
from app import app
import os
from .config import Config
API_URL=Config.API_URL
API_KEY=Config.API_KEY


@app.route('/uv', methods=['GET'])
def get_uv_data():
    lat = request.args.get('lat')
    lng = request.args.get('lng')
    
    if not lat or not lng:
        return jsonify({'error': 'Please provide both lat and lng parameters'}), 400

    try:
 
        response = requests.get(API_URL, headers={
            'apikey': API_KEY
        }, params={
            'lat': lat,
            'lng': lng
        })
        if response.status_code == 200:
            return jsonify(response.json()), 200
        else:
            return jsonify({
                'error': 'Failed to fetch data from Meersens API',
                'message': response.text  
            }), response.status_code
    except Exception as e:
        return jsonify({'error': str(e)}), 500