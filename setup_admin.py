import urllib.request
import json
import urllib.error

# Step 1: Register new user
url = 'http://localhost:8089/api/v1/users/register'
data = {
    "phone_number": "0888111222",
    "password": "admin123",
    "retype_password": "admin123",
    "fullname": "Root Admin",
    "date_of_birth": "1990-01-01",
    "facebook_account_id": 0,
    "google_account_id": 0,
    "role_id": 1
}

req = urllib.request.Request(url, data=json.dumps(data).encode('utf-8'), headers={'Content-Type': 'application/json'})
try:
    response = urllib.request.urlopen(req)
    print("REGISTER OK:", response.read().decode('utf-8'))
except urllib.error.HTTPError as e:
    body = e.read().decode('utf-8')
    print("Register error:", e.code, body)
    if 'already exists' in body:
        print("User already exists, proceeding to login test...")

# Step 2: Login to get token
login_url = 'http://localhost:8089/api/v1/users/login'
login_data = {
    "phone_number": "0888111222",
    "password": "admin123"
}
req2 = urllib.request.Request(login_url, data=json.dumps(login_data).encode('utf-8'), headers={'Content-Type': 'application/json'})
try:
    response2 = urllib.request.urlopen(req2)
    login_resp = response2.read().decode('utf-8')
    print("LOGIN OK:", login_resp)
except urllib.error.HTTPError as e:
    print("Login error:", e.code, e.read().decode('utf-8'))
except Exception as e:
    print("Login exception:", e)
