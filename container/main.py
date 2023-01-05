from flask import Flask, request

app = Flask(__name__)

def init_vscode_server():
    pass

@app.route('/')
def my_function(request):
  var = todo(...)
  connect = connect(...)
  connect(var)
  return 'ok',200

if __name__ == "__main__":
  app.run(host='0.0.0.0',port=int(os.environ.get('PORT',8080)))