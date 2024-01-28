#   #   #   #   #   #   #   #   #
#   #      Ray Example      #   #
#   #   #   #   #   #   #   #   #

# Login to AWS / Docker
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 665577950062.dkr.ecr.us-east-1.amazonaws.com

# Push to Remote Repository:::
docker compose build -t ray-example:latest .
docker tag ray-example:latest 665577950062.dkr.ecr.us-east-1.amazonaws.com/ray-example:latest
docker push 665577950062.dkr.ecr.us-east-1.amazonaws.com/ray-example:latest


#   #   #   #   #   #   #   #   
# Run:
docker compose up -d

#  Interact (Build & Run):
docker compose build -t ray-example . && docker compose up -d

# Build Local:
docker build -t localbuild:ray-example .

# Build from sratch:
docker build --no-cache -t ray-example .



# Tutorial
https://www.anyscale.com/blog/a-comprehensive-guide-for-building-rag-based-llm-applications-part-1



# Purge Docker (NO WARNING!!!):
docker system prune -f



# Cuda Transformers (add to Dockerfile)
RUN pip install ctransformers[cuda]
echo "AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID" >> /home/ubuntu/AWS_info.txt
   

# Test:
curl http://localhost:8000/ray-example/ POST -H "Content-Type: application/json" -v -d '{"en_text": "Towards Certification of Machine Learning-Based Distributed Systems Behavior"}'

curl http://localhost:8000/translate/en/fr/ POST -H "Content-Type: application/json" -v -d '{"en_text": "Towards Certification of Machine Learning-Based Distributed Systems Behavior"}'

## Might need to install "Transformers" from source in order to use all parts::
pip install git+https://github.com/huggingface/transformers
