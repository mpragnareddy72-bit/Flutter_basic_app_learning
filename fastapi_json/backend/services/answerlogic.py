import json

with open("jsonfile/countries.json", "r") as file:
    countries_data = json.load(file)

def find_answer(question: str) -> str:
    """
    Function to find an answer based on the question.
    
    Args:
        question (str): The question text.
        
    Returns:
        str: The answer text.
    """
    countries = countries_data["countries"] #it gives the list of countries from the countries dats dictionary file ,here json file stores as dictonary in countries data above
    #countries_name = [country["name"] for country in countries]
    question = question.lower()

    for country in countries:
        if country["name"].lower() in question:
            if "capital" in question:
                return f"The capital of {country['name']} is {country['capital']}."

            elif "currency" in question:
                return f"The currency of {country['name']} is {country['currency']}."

            elif "population" in question:
                return f"The population of {country['name']} is {country['population']}."

            elif "region" in question:
                return f"The region of {country['name']} is {country['region']}."

            elif "code" in question:
                return f"The country code of {country['name']} is {country['code']}."

            else:
                raise ValueError(
                    "I found the country, but I don't have information about that topic."
                )

    raise ValueError("Country not found.")
        
    # Implement your logic to find the answer here
    # For demonstration purposes, we'll return a simple response
   # return f"This is a response to your question: '{question}'"