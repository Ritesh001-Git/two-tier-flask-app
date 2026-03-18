# Base image
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Install system dependencies (NO upgrade)
RUN apt-get update && apt-get install -y \
    gcc \
    default-libmysqlclient-dev \
    pkg-config \
    build-essential \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy app
COPY . .

# Expose port (important for clarity)
EXPOSE 8000

# Run app
CMD ["python", "app.py"]
