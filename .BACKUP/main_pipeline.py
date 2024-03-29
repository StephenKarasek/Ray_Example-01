from transformers import pipeline

#pipe = pipeline("conversational", "HuggingFaceH4/zephyr-7b-beta")
pipe = pipeline("conversational", "mistralai/")
messages = [
    {
        "role": "system",
        "content": "You are a friendly chatbot who always responds in the style of a pirate",
    },
    {"role": "user", "content": "How many helicopters can a human eat in one sitting?"},
]
print(pipe(messages))