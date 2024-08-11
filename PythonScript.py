import requests
import mss
import numpy as np
import cv2

url = 'http://the-php-endpoint-here' #don't use the one I used in my video. 

def capture():
    with mss.mss() as sct:
        Monitor = sct.monitors[1]
        img = sct.grab(Monitor)
        img_np = np.array(img)
        img_bgr = cv2.cvtColor(img_np, cv2.COLOR_BGRA2BGR)
        img_resized = cv2.resize(img_bgr, (128, 72))

        _, buffer = cv2.imencode('.png', img_resized)
        image_data = buffer.tobytes()

        response = requests.post(url, files={'image': ('frame.png', image_data, 'image/png')})
        print(response.json())

while True:
    capture()
    cv2.waitKey(150)
