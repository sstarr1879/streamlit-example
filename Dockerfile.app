# Use an official Python runtime as a parent image
FROM python:3.10

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages specified in requirements.txt
RUN pip install --trusted-host pypi.python.org -r requirements.txt

# Run Streamlit when the container launches
CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.headless=true", "--server.enableCORS=false", "--server.enableWebsocketCompression=false"]