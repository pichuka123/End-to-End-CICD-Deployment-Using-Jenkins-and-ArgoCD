FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Optional: add trusted hosts
COPY requirements.txt .

RUN pip install -r requirements.txt

# Copy the rest of the application code 
COPY . /app

# Set default command and expose the port 8081 which is from app.py
EXPOSE 8081
CMD ["python","app.py"]


