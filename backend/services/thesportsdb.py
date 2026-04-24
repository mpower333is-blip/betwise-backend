import requests
import os

KEY=os.getenv("SPORTSDB_KEY")

def get_form(team):

   url=f"https://www.thesportsdb.com/api/v1/json/{KEY}/searchteams.php?t={team}"

   return requests.get(url).json()