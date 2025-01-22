# Base image
FROM apache/airflow:2.10.4

# Switch to root user for installing additional tools
USER root

# Install additional tools, clean up APT cache to reduce image size
RUN apt-get update && \
    apt-get install -y --no-install-recommends vim && \
    apt-get autoremove -yqq --purge && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Switch back to airflow user
USER airflow

# Copy requirements file and install Python dependencies
COPY requirements.txt /requirements.txt
RUN pip install --no-cache-dir -r /requirements.txt