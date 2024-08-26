# Use an official Python runtime as a parent image
FROM python:3.12-slim AS base

ARG MYUID=1000
ARG MYGID=1000

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . .

# Upgrade pip
RUN pip3 install --no-cache-dir --upgrade pip

# Install any needed packages specified in requirements.txt
RUN pip3 install --no-cache-dir -r requirements.txt


# Create a user and group to run the application
RUN groupadd -g "${MYGID}" python \
&& useradd --create-home --no-log-init -u "${MYUID}" -g "${MYGID}" python
USER python
CMD ["python3", "main.py"]