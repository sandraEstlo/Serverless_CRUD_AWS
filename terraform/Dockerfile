FROM hashicorp/terraform:1.9.8
WORKDIR /infra
COPY . .
CMD ["sh", "-c", "terraform init && terraform apply -auto-approve"]