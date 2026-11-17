# Ubuntu-Live-Satellite-Wallpaper
A script that pulls a satellite image, crops, and add city weather information



<img width="1440" height="1440" alt="goes" src="https://github.com/user-attachments/assets/64f0de4a-e8a4-444e-aa66-f0ef548a1a4f" />






Requires

ImageMagick          https://imagemagick.org/download/#gsc.tab=0

Gnome Extensions     https://extensions.gnome.org/

Wallpaper Carousel   https://github.com/SpiritualRose/wallpaper-carousel




___________________
1




Make a folder for the output photo will be stored.

Default: $HOME/Pictures/LiveGOES/goes.jpg
this can be edited at the top of the script.


___________________
2

Pick a satellite image on https://cdn.star.nesdis.noaa.gov/GOES19/ABI/SECTOR/

This link brings you to the GOES-19 sector selection directory of NOAA API.
From here you can select what region of photos you want.
Once you pick a sector then select the filter you want to see at the bottom of the directory.
Finally scroll to the bottom of the list of photos and find the latest.jpg
Keep in mind you can crop and reposition the image in the script.

Default: https://cdn.star.nesdis.noaa.gov/GOES19/ABI/FD/GEOCOLOR/latest.jpg
This can be edited at the top of the script.

<img width="678" height="678" alt="678x678" src="https://github.com/user-attachments/assets/3e664d6c-978f-4871-9a75-a1af816856cb" />

___________________
3

Use the image controls at the bottom of the script the edit the image.
delete the location and font lines if you don't want them displayed

  -crop 10848x10848+100+100 +repage \   #Crop the image -crop ImageXxImageY+OffsetX+OffsetY
  
  -resize 2560x1440 \   #Resize the final image
  
  -fill "#FF3B30" \   #Location point fill color
  
  -stroke "white" \  #Location border color
  
  -strokewidth 2 \  #Location border size
  
  -draw "circle 1000,500 1000,505" \   #Draws the circle with the difference of the two origins being the size of the circle. duplicate this line to add more locations. -draw "circle Origin1X,Origin1Y Origin2X,Origin2Y"
  
  -font "DejaVu-Sans-Bold" \ #Set font
  
  -pointsize 18 \ #Font size
  
  -fill "white" \ #Font color
  
  -stroke "black" \ #Font border color
  
  -strokewidth 2 \ #Font border size
  
  -annotate +1778+817 "Location1: $Location1_WX" \  #Draws text at the offset +1778+817 with the string containing the weather info


___________________
4

Select the weather location.
Each location need these lines

Location1_URL="https://api.open-meteo.com"
Location1_WX=$(curl -s "$Location1_URL" | python3 -c "$FORMAT_PY" 2>/dev/null)

To find the API URL go to [https://open-meteo.com/en/docs](https://open-meteo.com/en/docs?current=temperature_2m,relative_humidity_2m,apparent_temperature,wind_speed_10m,precipitation,showers,rain,snowfall)

This URL already has the default metrics selected so all you have to do is select the location.
Once you have the location selected scroll down to the API Response and copy the generated URL into the script 


___________________
5

Use cron to setup the script every 30 minutes.

Example:  */30 * * * * /PathTo/get-goes-image.sh

___________________
6


Use wallpaper-carousel and set it to look inside the output photos folder and set to refresh every 30 minutes. 

this makes my Ubuntu 26 wallpaper be updated every 30 minutes with the latest GOES image.




