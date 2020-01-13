import sys
import yaml
import json


with open(sys.argv[1]) as file:
    documents = yaml.full_load(file)
    print(json.dumps(documents))
