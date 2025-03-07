# Use the official dbt base image
FROM ghcr.io/dbt-labs/dbt-postgres:latest

# Install git
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

COPY packages.yml /app/packages.yml
COPY profiles.yml /app/profiles/profiles.yml
COPY get_run_id.py /app/get_run_id.py

#RUN dbt deps --profiles-dir /dev/null --project-dir /dev/null --select dbt-utils

# Set working directory
WORKDIR /app

# Set up environment variables (if needed)
ENV DBT_PROFILES_DIR=/app/profiles

# Entrypoint script to run dbt and handle results
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]
