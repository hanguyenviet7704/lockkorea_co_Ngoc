import urllib.request
import json
import urllib.error
import random
import time

phone = "0" + str(random.randint(100000000, 999999999))
url = 'http://localhost:8089/api/v1/users/register'
data = {
    "phone_number": phone,
    "password": "admin",
    "retype_password": "admin",
    "fullname": "Super Admin II",
    "date_of_birth": "1990-01-01",
    "facebook_account_id": 0,
    "google_account_id": 0,
    "role_id": 1
}

req = urllib.request.Request(url, data=json.dumps(data).encode('utf-8'), headers={'Content-Type': 'application/json'})
try:
    response = urllib.request.urlopen(req)
    print("SUCCESS_PHONE:", phone)
    print("Response:", response.read().decode('utf-8'))
except urllib.error.HTTPError as e:
    print("Error:", e.code, e.read().decode('utf-8'))
except Exception as e:
    print("Exception:", e)
