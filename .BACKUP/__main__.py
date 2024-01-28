from llama_cpp import Llama
import boto3
import requests


prompt = "Q: What is the distance from earth to mars? A:"

model_path = "./models/mistral-7b-instruct-v0.1.Q2_K.gguf"
#model_path = "./models/mistral-7b-instruct-v0.1.Q8_0.gguf"


def run_model(model_path="mistral-7b-instruct-v0.1.Q2_K.gguf"):
    '''
    '''
    #./models/llama-7b.Q8_0.gguf
    llm = Llama(model_path)
    return llm

'''
LLM = run_model(model_path)

output = LLM(prompt)

print(output["choices"][0]["text"])
'''
LLM = run_model()


def query_local_llm(endpoint, data, headers=None):
    """
    Send a request to the local LLM API.

    :param endpoint: The local API endpoint for the LLM.
    :param data: The data to be sent in the request (e.g., input text for the model).
    :param headers: Optional dictionary containing request headers.
    :return: Response object or None if request failed.
    """
    output = LLM(prompt)

    
    try:
        response = requests.post(endpoint, json=data, headers=headers)
        response.raise_for_status()  # Raise an error for bad status codes
        return response.json()
    except requests.RequestException as e:
        print(f"An error occurred: {e}")
        return None
    

    #return output["choices"][0]["text"]




# Control for endpoint
def question(prompt):

    output = LLM(prompt)

    return output["choices"][0]["text"]



if __name__ == "__main__":
    prompt = "Q: What is the distance from earth to mars? A:"

    # Example usage
    local_api_url = "http://localhost:8080/query"
    query_data = {"prompt": "Q: What is the distance from earth to mars? A:"}
    headers = {'Content-Type': 'application/json'}

    response = query_local_llm(local_api_url, query_data, headers=headers)

    if response:
        print(response)  # Process the response as needed



    answer = question(prompt)

    print(answer)


