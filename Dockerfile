FROM python:3.9-slim

# Set working directory
WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .
EXPOSE 5000
CMD ["python","app.py"]
ENTRYPOINT && /bin/bash 



