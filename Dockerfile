# FROM python:3.10-slim-buster

# WORKDIR /app

# COPY . /app

# RUN pip install -r requirements.txt

# CMD ["python3", "app.py"]

FROM python:3.10-slim

WORKDIR /app

# Install system dependencies (IMPORTANT for ML libs)
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    git \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first (for caching)
COPY requirements.txt .

# Upgrade pip
RUN pip install --upgrade pip

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY . .

# Expose port
EXPOSE 5000

# Run app
CMD ["python", "app.py"]