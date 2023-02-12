import json
from colorama import Fore
print(f'''{Fore.BLUE}
        _        _ _                                   
       | |      | (_)                                  
 __   _| |_   __| |_ ___  ___ _____   _____ _ __ _   _ 
 \ \ / / __| / _` | / __|/ __/ _ \ \ / / _ \ '__| | | |
  \ V /| |_ | (_| | \__ \ (_| (_) \ V /  __/ |  | |_| |
   \_/  \__| \__,_|_|___/\___\___/ \_/ \___|_|   \__, |
         ______                                   __/ |
        |______|                                 |___/ 
                github.com/johnk3r {Fore.RESET}''')

# Load the JSON data as a string
with open("api.json", "r") as file:
    json_data = file.read()

# Parse the JSON data
parsed_data = json.loads(json_data)

# Access the meaningful_name
meaningful_name = parsed_data['data'][0]['attributes']['meaningful_name']

# Access the sha256
sha256 = parsed_data['data'][0]['attributes']['sha256']

# Access the threat value
threat = parsed_data['data'][0]['attributes']['popular_threat_classification']['suggested_threat_label']

# Access the trid array
trid = parsed_data['data'][0]['attributes']['trid'][0]['file_type']

# Access the crowdsourced_yara_results array
crowd_yara = parsed_data['data'][0]['attributes']['crowdsourced_yara_results'][0]['rule_name']

# Access the crowdsourced_ids_results array
crowd_ids = parsed_data['data'][0]['attributes']['crowdsourced_ids_results'][0]['rule_msg']

# Access the crowdsourced_sigma_results array
crowd_sigma = parsed_data['data'][0]['attributes']['sigma_analysis_results'][0]['rule_title']

# Access the notification_source_country array
notification_source = parsed_data['data'][0]['context_attributes']['notification_source_country']

# Access the notification_source_country array
livehunt_rule = parsed_data['data'][0]['context_attributes']['ruleset_name']

# Print the information
print("File Name: ", meaningful_name)
print("SHA256: ", sha256)
print("Possible Threat: ", threat)
print("Trid: ", trid)
print("Crowdsourced Yara: ", crowd_yara)
print("Crowdsourced IDS: ", crowd_ids)
print("Crowd Sigma: ", crowd_sigma)
print("Notification Source: ", notification_source)
print("LiveHunt Rule: ", livehunt_rule)
