import requests
import os

KEY = os.getenv("API_SPORTS_KEY")

def get_soccer_odds():

    url="https://v3.football.api-sports.io/odds"

    headers={
      "x-apisports-key":KEY
    }

    r=requests.get(url,headers=headers)

    return r.json()