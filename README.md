# Open-Weather

Open Weather is a sample application which shows weather info for the city entered. It gets weather info from service api provided by openweathermap.org

Open Weatheraapp allow User to enter a US city. The applications gets weather info from openweathermap.org service api and display the information like current temperature,
max, min temp, weather decsription and weather icon.
 
Also app Auto loads the last city searched upon app launch.


WeatherInfoViewController :

         Controlls UI componets like WeatherInfoView and searchbar. It Gets weather info from OWWeatherInfoRepository and      display it in WeatherInfoView.

WeatherInfoView:

         A UIView that displays weather details

OWNetworkManager:

         A singleton class that handles OWNetworkClient for network communications.

OWNetworkClient :

         Implements network communications

WeatherInfoObject:

         Data object for weather info details.



 
