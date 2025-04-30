# Grab the latest alpine image
FROM alpine:latest

# Install python3, pip, bash, and venv tools
RUN apk add --no-cache --update python3 py3-pip py3-virtualenv bash

# Create a virtual environment
RUN python3 -m venv /venv

# Copy requirements
ADD ./webapp/requirements.txt /tmp/requirements.txt

# Install dependencies in the virtual environment
RUN /venv/bin/pip install --no-cache-dir -r /tmp/requirements.txt

# Add our code
ADD ./webapp /opt/webapp/
WORKDIR /opt/webapp

# Expose is NOT supported by Heroku
# EXPOSE 5000

# Run the image as a non-root user
RUN adduser -D myuser
USER myuser

# Ensure the virtualenv is in PATH
ENV PATH="/venv/bin:$PATH"

# CMD is required to run on Heroku
CMD ["gunicorn", "--bind", "0.0.0.0:$PORT", "wsgi"]

