from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/')
def home():
    return jsonify({
        "status": "success",
        "message": "Hello from Python Docker Demo!",
        "multistage": "Learning Docker Multi-stage Builds"
    })

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
