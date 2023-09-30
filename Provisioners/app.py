
from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello, My Name is Pradip"

if __name__ == "__main__":
    # Use environment variables or a configuration file for settings
    app.run(host="0.0.0.0", port=80)  # Use a non-privileged port for development
