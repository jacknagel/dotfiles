""" Print the current weather for the passed place.
Original by limitedmage.

    Edited by Beau Martínez:
        * Ported to Python 3.
        * We now parse the XML as opposed to regexing it (as to allow for extensibility).
        * Modularised code.

    Edited again by Jack Nagel:
        * Modded to return additional information.
        * Now takes one argument, a postal code, so that I can run it when my shell starts.
        * Edited the format of the output.
"""

from urllib import request
import xml.etree.ElementTree as etree
from io import StringIO
import sys

# Constants.

GOOGLE_WEATHER_URL = "http://www.google.com/ig/api?weather={}"

# Functions.

def urlResponseAsFile(url):
    """ Opens the passed URL and returns its response as a file.
    """

    response = request.urlopen(url)
    bytes = response.read()
    string = bytes.decode("utf-8")
    file = StringIO(string)

    return file

def getWeather(place):
    """ Returns the current weather for the passed place.
    """

    url = GOOGLE_WEATHER_URL.format(request.quote(place))

    xml = urlResponseAsFile(url)

    # Parse the XML.

    tree = etree.parse(xml)
    cityElement = (tree.find("//forecast_information"))
    weatherElement = (tree.find("//current_conditions"))

    # Retrieve the condition and temperature.
    city = cityElement.find("city").attrib["data"]
    condition = weatherElement.find("condition").attrib["data"].lower().capitalize()
    temperature = int(weatherElement.find("temp_f").attrib["data"])
    wind = weatherElement.find("wind_condition").attrib["data"].split(' ',2)

    # Compose the weather string.
    # Current conditions in City, ST: Condition, degF, with Wind: NW at 1 mph
    weather = "Current conditions in %s: %s, %d °F with %s wind %s" % (city, condition, temperature, wind[1], wind[2])

    return weather

def main():
    weather = getWeather(sys.argv[1])

    print(weather)

# Script.

if __name__ == "__main__":
    main()
