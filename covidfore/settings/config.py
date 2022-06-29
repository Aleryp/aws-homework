
import os


name = "Covid Forecast"

host = "0.0.0.0"

port = int(os.environ.get("PORT", 80))

debug = False

contacts = "https://t.me/AleRyp"

code = "https://github.com/aleryp"


fontawesome = 'https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css'


root = os.path.dirname(os.path.dirname(__file__)) + "/"
