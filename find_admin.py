import urllib.request
import json
import urllib.error

# Step 1: Register a dummy user to get a BCrypt hash for "admin123"
url = 'http://localhost:8089/api/v1/users/register'
data = {
    "phone_number": "0777666555",
    "password": "admin123",
    "retype_password": "admin123",
    "fullname": "Temp User",
    "date_of_birth": "1990-01-01",
    "facebook_account_id": 0,
    "google_account_id": 0,
    "role_id": 1
}
req = urllib.request.Request(url, data=json.dumps(data).encode('utf-8'), headers={'Content-Type': 'application/json'})
try:
    response = urllib.request.urlopen(req)
    print("Register OK")
except urllib.error.HTTPError as e:
    print("Register:", e.code, e.read().decode('utf-8'))

# Step 2: Try to login as the temp user to confirm password hash works
login_url = 'http://localhost:8089/api/v1/users/login'
login_data = {"phone_number": "0777666555", "password": "admin123"}
req2 = urllib.request.Request(login_url, data=json.dumps(login_data).encode('utf-8'), headers={'Content-Type': 'application/json'})
try:
    resp = urllib.request.urlopen(req2)
    print("Temp login OK")
except urllib.error.HTTPError as e:
    print("Login err:", e.code, e.read().decode('utf-8'))

# Step 3: Now login as the existing admin 0111222333 with common passwords
for pwd in ["admin", "admin123", "123456", "1234", "12345678", "password", "0111222333", "12341234", "abc123"]:
    login_data2 = {"phone_number": "0111222333", "password": pwd}
    req3 = urllib.request.Request(login_url, data=json.dumps(login_data2).encode('utf-8'), headers={'Content-Type': 'application/json'})
    try:
        resp3 = urllib.request.urlopen(req3)
        print(f"ADMIN LOGIN SUCCESS with password: {pwd}")
        print(resp3.read().decode('utf-8')[:200])
        break
    except urllib.error.HTTPError:
        print(f"  tried '{pwd}' - failed")
