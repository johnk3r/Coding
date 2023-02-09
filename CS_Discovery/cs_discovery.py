import re
import ssl
from urllib.request import urlopen
from jarm.scanner.scanner import Scanner
from traceback import format_exc as print_traceback
from requests.packages.urllib3 import disable_warnings
from requests.packages.urllib3.exceptions import InsecureRequestWarning
from argparse import ArgumentParser, SUPPRESS, HelpFormatter

configs = {
    "port_regex": ":([0-9]+)",
    "domains_regex": "^((?!-)[A-Za-z0-9-]{1,63}(?<!-)\\.)[A-Za-z]{2,6}",
    "clear_input_to_jarm": r"(https?:\/\/)?([w]{3}\.)?(\w*.\w*)([\/\w]*)",
    "response_msg": "BAD REQUEST: Bad percent-encoding.",
    "argparser": {
        "desc_general": "Cobalt Strike Discover - Finding Cobalt Strike Fingerprint.",
        "url": "Single url to check",
        "file": "File path with urls to check",
        "help": "Show this help message and exit."
    },
    "logs": {
        "try_detect_byte": "[>] ~ Trying detect using encoded byte",
        "cs_possible": "\t[!] ~ Possible Cobalt Strike detected in url {} using encoded byte",
        "no_indicator": "\t[>] ~ No indicator was found in url {} using encoded byte",
        "get_jarm": "\t[>] ~ Jarm: {}\n",
        "key_interrupt": "[!] ~ Well, it looks like someone interrupted the execution...",
        "error": "[!] ~ An error occurred: {}"
    },
    "logo": r'''
       _____      _           _ _      _____ _        _ _          _____  _                                   
      / ____|    | |         | | |    / ____| |      (_) |        |  __ \(_)                                  
     | |     ___ | |__   __ _| | |_  | (___ | |_ _ __ _| | _____  | |  | |_ ___  ___ _____   _____ _ __ _   _ 
     | |    / _ \| '_ \ / _` | | __|  \___ \| __| '__| | |/ / _ \ | |  | | / __|/ __/ _ \ \ / / _ \ '__| | | |
     | |___| (_) | |_) | (_| | | |_   ____) | |_| |  | |   <  __/ | |__| | \__ \ (_| (_) \ V /  __/ |  | |_| |
      \_____\___/|_.__/ \__,_|_|\__| |_____/ \__|_|  |_|_|\_\___| |_____/|_|___/\___\___/ \_/ \___|_|   \__, |
                                                                                                         __/ |
                                                                                                        |___/  
    
                                [>] Finding Cobalt Strike Fingerprint
                                [>] by Johnatan Zacarias and Higor Melgaço                   
    '''
}


class CustomHelpFormatter(HelpFormatter):
    def __init__(self, prog):
        super().__init__(prog, max_help_position=50, width=100)

    def format_action_invocation(self, action):
        if not action.option_strings or action.nargs == 0:
            return super().format_action_invocation(action)
        default = self._get_default_metavar_for_optional(action)
        args_string = self._format_args(action, default)
        return ', '.join(action.option_strings) + ' ' + args_string


def acquire_jarm(address: str) -> str:
    """
    receives a user input, validate itself and get jarm
    :param address: domain, url or ip
    :return: jarm signature
    """
    port, subst = None, "\\3"
    try:
        port = int(re.search(configs["port_regex"], address).group().replace(":", ""))
    except Exception:
        port = 443

    input_cleared = re.sub(configs["clear_input_to_jarm"], subst, address, 0, re.MULTILINE | re.IGNORECASE)
    domain = re.search(configs["domains_regex"], input_cleared)

    if domain is not None:
        try:
            return Scanner.scan(domain.string, port)[0]
        except Exception:
            return "unknown"


if __name__ == "__main__":
    arg_style = lambda prog: CustomHelpFormatter(prog)
    args = ArgumentParser(description=configs["argparser"]["desc_general"], add_help=False, formatter_class=arg_style)
    group_required = args.add_argument_group(title="required arguments")
    group_required.add_argument("-u", "--url", metavar="<url>", type=str, help=configs["argparser"]["url"])
    group_required.add_argument("-f", "--file", metavar="<file>", type=str, help=configs["argparser"]["file"])
    group_optional = args.add_argument_group(title="optional arguments")
    group_optional.add_argument("-h", "--help", help=configs["argparser"]["help"], action="help", default=SUPPRESS)

    try:
        ssl._create_default_https_context = ssl._create_unverified_context
        # request warning disable
        disable_warnings(InsecureRequestWarning)
        print(configs['logo'])
        request_error, urls = None, list()

        arguments = args.parse_args()
        if arguments.url:
            urls.append(arguments.url)
        elif arguments.file:
            with open(arguments.file, "r+") as file_urls:
                urls = [url.strip() for url in file_urls.readlines()]
        else:
            args.print_help()
            exit(0)

        print(configs["logs"]["try_detect_byte"])
        for url in urls:
            try:
                response = urlopen(f"{url}/%0".strip().replace("//%", "/%"))
            except Exception as error:
                request_error = str(error.read().decode())

            if request_error == configs["response_msg"]:
                print(configs["logs"]["cs_possible"].format(url))
                jarm = acquire_jarm(url)
                print(configs["logs"]["get_jarm"].format(jarm))
            else:
                print(configs["logs"]["no_indicator"].format(url.strip()))

    except KeyboardInterrupt:
        print(configs["logs"]["key_interrupt"].format(configs["logs"]["key_interrupt"]))
    except Exception:
        print(configs["logs"]["error"].format(print_traceback()))
