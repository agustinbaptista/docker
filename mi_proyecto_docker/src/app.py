from falsk import Flask

app = Flask(__name__)

@app.route('/')
def index():
    return 'Proyecto mundo'

if __name__ == '__main__':
  app.rum(debug=True, host='0.0.0.0')
