from flask import Flask, redirect, request, session, url_for, render_template, jsonify
import subprocess
import os
import time
import signal
app = Flask(__name__)
count = 0
app.secret_key = '636f0abc2676d20247605be1b21d0276'
@app.route('/')
def index():
    message = session.get('ready', '')
    return render_template('index.html', message=message)
@app.route('/run-script', methods=['GET'])
def run_script():
    arg = request.args.get('arg')
    subprocess.Popen(['/script.sh', arg])
    if arg == 'win1':
        global count
        if count == 0:
            count = count + 1
            time.sleep(5)
        else:
            time.sleep(2)
        result = subprocess.Popen(['bash', '-c', 'exec /dos-auto.exp'], text=True) 
        result.communicate()
        result.terminate()
    session['ready'] = 'http://localhost:5335-currently running: -{arg}-after you click on novnc, do not press anything on the keyboard, the system will start itself in a few seconds, especially windows 1, you need to wait about 22~28 seconds'.format(arg=arg)
    return redirect(url_for('index'))
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8888, debug=True)
