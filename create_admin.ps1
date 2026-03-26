$body = @{
    phone_number = "0999888777"
    password = "admin"
    retype_password = "admin"
    fullname = "Super Admin"
    date_of_birth = "1990-01-01"
    facebook_account_id = 0
    google_account_id = 0
    role_id = 1
} | ConvertTo-Json

Invoke-RestMethod -Uri "http://localhost:8089/api/v1/users/register" -Method Post -Headers @{"Content-Type"="application/json"} -Body $body
