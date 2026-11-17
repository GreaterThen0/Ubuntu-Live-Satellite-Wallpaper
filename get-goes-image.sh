#!/bin/bash

#BaseImageURL
IMAGE_URL="https://cdn.star.nesdis.noaa.gov/GOES19/ABI/FD/GEOCOLOR/latest.jpg"

#Output File Dir
OUTPUT_FILE="$HOME/Pictures/LiveGOES/goes.jpg"

# Shared Open-Meteo current parameters
METRICS="temperature_2m,relative_humidity_2m,apparent_temperature,wind_speed_10m,precipitation,rain,showers,snowfall"

# Python helper to format the multi-line weather readout
FORMAT_PY="import sys, json
c = json.load(sys.stdin)['current']
print(f\"{round(c['temperature_2m'])}°C (Feels {round(c['apparent_temperature'])}°C)\n\"
      f\"Humidity: {c['relative_humidity_2m']}% | Wind: {round(c['wind_speed_10m'])} km/h\n\"
      f\"Precip: {c['precipitation']}mm | Rain: {c['rain']}mm\n\"
      f\"Showers: {c['showers']}mm | Snow: {c['snowfall']}cm\")"

#Go to https://open-meteo.com/en/docs and select the desired location then set it to collect the current data listed in the METRICS Finally copy the API URL generated under API RESPONSE on the page and put it in the LOCATION1_URL
Location1_URL="https://api.open-meteo.com/v1/forecast?latitude=40.7143&longitude=-74.006&hourly=temperature_2m&current=temperature_2m,relative_humidity_2m,apparent_temperature,wind_speed_10m,precipitation,showers,rain,snowfall"
Location1_WX=$(curl -s "$Location1_URL" | python3 -c "$FORMAT_PY" 2>/dev/null)

Location2_URL="https://api.open-meteo.com/v1/forecast?latitude=19&longitude=-70.6667&hourly=temperature_2m&current=temperature_2m,relative_humidity_2m,apparent_temperature,wind_speed_10m,precipitation,showers,rain,snowfall"
Location2_WX=$(curl -s "$Location2_URL" | python3 -c "$FORMAT_PY" 2>/dev/null)




#Adjust the crop below to crop the region you desire

#Resize sets the final photo size

#Add    -draw "circle 1000,500 1000,505" \    for each location you want pointed on the map and change the number values to get to the correct location and add 5 to one of the Y positions to set the size of the circle

#add     -annotate +1778+817 "Location1: $Location1_WX" \     for each location you want weather info on the location works the same as the -draw


# Fallback text if offline
[ -z "$Location1_WX" ] && Location1_WX="N/A"
[ -z "$Location2_WX" ] && Location2_WX="N/A"

curl -fsSL "$IMAGE_URL" | magick jpg:- \
  -crop 10848x10848+100+100 +repage \
  -resize 2560x1440 \
  -fill "#FF3B30" \
  -stroke "white" \
  -strokewidth 2 \
  -draw "circle 720,180 720,185" \
  -draw "circle 830,440 830,445" \
  -font "DejaVu-Sans-Bold" \
  -pointsize 18 \
  -fill "white" \
  -stroke "black" \
  -strokewidth 1 \
  -annotate +725+185 "New York: $Location1_WX" \
  -annotate +835+450 "Dominican Republic: $Location2_WX" \
   "$OUTPUT_FILE"
