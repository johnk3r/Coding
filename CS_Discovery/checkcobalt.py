import urllib.request
import urllib.parse
import logging
import ssl
ssl._create_default_https_context = ssl._create_unverified_context

# Read URL
try:
 payload = 'BAD REQUEST: Bad percent-encoding.'
 url = input("Input URL: ")
 req = urllib.request.urlopen(f"{url}/%0")
 print(req.read())

# Catching the exception generated
except Exception as e :
        value = str(e.read().decode())
if value == payload:
    print ('Possible Cobalt Strike detected using encoded byte!')
else:
    print ('No indicator was found!')
