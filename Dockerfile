FROM python:3.10-slim

# Set environment variables
ENV CKAN_HOME=/usr/lib/ckan/default
ENV CKAN_VENV=$CKAN_HOME
ENV CKAN_CONFIG=/etc/ckan
ENV CKAN_STORAGE_PATH=/var/lib/ckan/default
ENV CKAN_INI=$CKAN_CONFIG/production.ini

# Install system dependencies
RUN apt-get update && apt-get install -y \
    postgresql-client \
    libpq-dev \
    python3-dev \
    libxml2-dev \
    libxslt1-dev \
    libgeos-dev \
    libssl-dev \
    libffi-dev \
    git \
    curl \
    gcc \
    g++ \
    make \
    redis-tools \
    && rm -rf /var/lib/apt/lists/*

# Create directories
RUN mkdir -p $CKAN_HOME $CKAN_CONFIG $CKAN_STORAGE_PATH && \
    chown -R www-data:www-data $CKAN_HOME $CKAN_CONFIG $CKAN_STORAGE_PATH

# Set working directory
WORKDIR /usr/src

# Copy CKAN source code
COPY . /usr/src/ckan

# Install CKAN and dependencies
RUN pip install --no-cache-dir -U pip && \
    pip install --no-cache-dir -e /usr/src/ckan && \
    pip install --no-cache-dir -r /usr/src/ckan/requirements.txt && \
    pip install --no-cache-dir waitress

# Copy custom templates and static files
COPY ckan/templates /usr/src/ckan/ckan/templates
COPY ckan/public /usr/src/ckan/ckan/public

# Create entrypoint script
RUN echo '#!/bin/bash\n\
set -e\n\
\n\
# Wait for PostgreSQL\n\
echo "Waiting for PostgreSQL..."\n\
until pg_isready -h ${CKAN_DB_HOST} -p ${CKAN_DB_PORT} -U ${CKAN_DB_USER}; do\n\
  echo "PostgreSQL is unavailable - sleeping"\n\
  sleep 2\n\
done\n\
echo "PostgreSQL is up"\n\
\n\
# Wait for Solr\n\
echo "Waiting for Solr..."\n\
until curl -s http://${CKAN_SOLR_HOST}:${CKAN_SOLR_PORT}/solr/ > /dev/null; do\n\
  echo "Solr is unavailable - sleeping"\n\
  sleep 2\n\
done\n\
echo "Solr is up"\n\
\n\
# Wait for Redis\n\
echo "Waiting for Redis..."\n\
until redis-cli -h ${CKAN_REDIS_HOST} -p ${CKAN_REDIS_PORT} ping > /dev/null 2>&1; do\n\
  echo "Redis is unavailable - sleeping"\n\
  sleep 2\n\
done\n\
echo "Redis is up"\n\
\n\
# Run CKAN\n\
echo "Starting CKAN..."\n\
exec ckan -c ${CKAN_INI} run --host 0.0.0.0 --port 5000\n\
' > /docker-entrypoint.sh && chmod +x /docker-entrypoint.sh

# Expose port
EXPOSE 5000

# Set user
USER www-data

# Entrypoint
ENTRYPOINT ["/docker-entrypoint.sh"]

