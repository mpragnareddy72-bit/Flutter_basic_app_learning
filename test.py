

import json

with open("countries.json", 'r', encoding='utf-8') as file:
    data = json.load(file)
print(data)