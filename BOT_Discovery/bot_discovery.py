import requests
import json
from colorama import Fore
print(f'''{Fore.BLUE}
  _           _        _ _
 | |         | |      | (_)
 | |__   ___ | |_   __| |_ ___  ___ _____   _____ _ __ _   _
 | '_ \ / _ \| __| / _` | / __|/ __/ _ \ \ / / _ \ '__| | | |
 | |_) | (_) | |_ | (_| | \__ \ (_| (_) \ V /  __/ |  | |_| |
 |_.__/ \___/ \__| \__,_|_|___/\___\___/ \_/ \___|_|   \__, |
               ______                                   __/ |
              |______|                                 |___/

                    github.com/johnk3r {Fore.RESET}''')

telegram_bot_token = input("Enter T.me Bot Token: ")
url = f"https://api.telegram.org/bot{telegram_bot_token}/getMe"

resp = requests.get(url).json()
result = resp["result"]

print("ID:", result["id"])
print("Is Bot:", result["is_bot"])
print("First Name:", result["first_name"])
print("Username:", result["username"])

logout_bot = input("Do you want to logOut of this bot? (yes/no) ")

if logout_bot.lower() == "yes":
    urlogout = f"https://api.telegram.org/bot{telegram_bot_token}/logOut"
    reslogout = requests.get(urlogout).json()
    print(reslogout)

#    if response.status_code == 200:
#        print("Retrieved URL:", random_url)
#    else:
#        print("Request failed with status code", response.status_code)
#else:
#    print("Message will not be deleted.")
