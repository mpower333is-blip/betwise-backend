from flask import Flask,jsonify
from engines.soccer_engine import generate_pick

app=Flask(__name__)

@app.route("/premium-picks")
def picks():

   return jsonify([
      generate_pick()
   ])

if __name__=="__main__":
   app.run()