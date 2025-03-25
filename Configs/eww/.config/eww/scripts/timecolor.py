#!/usr/bin/env python
from datetime import datetime
from requests import get

exit(0)
# get seconds past midnight
now = datetime.now()
midnight = now.replace(hour=0, minute=0, second=0, microsecond=0)
seconds = (now - midnight).seconds

def hex_to_rgb(hex_color):
    """Convert a hex color to an RGB tuple."""
    hex_color = hex_color.lstrip('#')
    return tuple(int(hex_color[i:i + 2], 16) for i in (0, 2, 4))

def rgb_to_hex(rgb_color):
    """Convert an RGB tuple to a hex color."""
    return '#' + ''.join(f'{int(c):02x}' for c in rgb_color)

def interpolate_color(color1, color2, percentage):
    """Interpolate between two hex colors by a given percentage."""
    rgb1 = hex_to_rgb(color1)
    rgb2 = hex_to_rgb(color2)
    
    # Calculate the interpolated RGB values
    interpolated_rgb = (
        int(rgb1[0] + (rgb2[0] - rgb1[0]) * percentage),
        int(rgb1[1] + (rgb2[1] - rgb1[1]) * percentage),
        int(rgb1[2] + (rgb2[2] - rgb1[2]) * percentage)
    )
    
    return rgb_to_hex(interpolated_rgb)

SUNRISE = 6 * 60 * 60
SUNSET = 18 * 60 * 60
NOON = 12 * 60 * 60
TIME_BLOCK = 6 * 60 * 60

if seconds < SUNRISE:
    color = interpolate_color('#0000FF', '#fc5d00', (seconds + SUNRISE) / TIME_BLOCK / 2)
elif SUNRISE <= seconds < NOON:
    color = interpolate_color('#fc5d00', '#FFFF00', (seconds - SUNRISE) / TIME_BLOCK)

print(color)
