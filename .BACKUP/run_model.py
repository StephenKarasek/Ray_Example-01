from llama_cpp import Llama


def run_model(model_path="./models/llama-7b.Q8_0.gguf"):
    '''

    '''
    llm = Llama(model_path)
    return llm

prompt = "Q: What is the distance from earth to mars? A:"

model_path = "./models/mistral-7b-instruct-v0.1.Q2_K.gguf"
#model_path = "./models/mistral-7b-instruct-v0.1.Q8_0.gguf"

LLM = run_model(model_path)

output = LLM(prompt)

print(output["choices"][0]["text"])