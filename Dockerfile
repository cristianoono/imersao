# Etapa 1: Imagem base
# Usamos uma imagem oficial do Python. A versão 'slim' é menor e boa para produção,
# e a versão 3.10 é compatível com o que é pedido no readme.md.
FROM python:3.10-slim

# Definir variáveis de ambiente para otimizar a execução do Python em contêineres
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Etapa 2: Diretório de trabalho
# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Etapa 3: Instalar dependências
# Copia primeiro o arquivo de requisitos para aproveitar o cache de camadas do Docker.
# Se o requirements.txt não mudar, o Docker não reinstalará as dependências.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Etapa 4: Copiar o código da aplicação
# O .dockerignore garantirá que arquivos desnecessários (como venv e escola.db) não sejam copiados.
COPY . .

# Etapa 5: Expor a porta que a aplicação usa
EXPOSE 8000

# Etapa 6: Comando de execução
# Executa a aplicação com uvicorn. O host 0.0.0.0 torna a aplicação acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
