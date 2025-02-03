from flask import Flask, jsonify, request
from datetime import datetime
import requests

app = Flask(__name__)

def get_public_ip():
    """Fetch the real public IP of the client using an external API."""
    try:
        response = requests.get("https://api64.ipify.org?format=json")
        return response.json().get("ip", "Unknown")
    except:
        return "Unknown"

@app.route("/", methods=["GET"])
def get_time():
    return jsonify({
        "timestamp": datetime.utcnow().isoformat(),
        "ip": get_public_ip()  # Get the correct public IP
    })

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
