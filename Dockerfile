# Pull base image
FROM python:3.8-slim-buster

# Maintainer
LABEL author="Carlos Zúñiga" contact="carlos.ezv@outlook.com"

# Open default Flask port
EXPOSE 5000

# Environment variables to stop .pyc files and turn off buffering
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Add working directory
WORKDIR /hello_flask
ADD . /hello_flask

# Install pip requirements
ADD requirements.txt .
RUN python -m pip install -r requirements.txt

# Switching to a non-root user
RUN useradd appuser && chown -R appuser /hello_flask
USER appuser

# Start webserver and bind port
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "hello_flask.webapp:app"]
