# Use an official Python runtime as a parent image
FROM python:3.10

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages specified in requirements.txt
RUN pip install --trusted-host pypi.python.org -r requirements.txt

# Install NGINX
RUN apt-get update && apt-get install -y nginx

# Remove the default NGINX configuration
RUN rm /etc/nginx/sites-enabled/default

# Copy the NGINX configuration file into the container
COPY nginx.conf /etc/nginx/sites-available/
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY certs /etc/ssl/certs

# Link the NGINX config file
RUN ln -s /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/

# Expose port 443 to the outside world
EXPOSE 443

# Run NGINX and Streamlit when the container launches
CMD service nginx start && streamlit run app.py --server.port=8501 --server.headless=true --server.enableCORS=false --server.enableWebsocketCompression=false