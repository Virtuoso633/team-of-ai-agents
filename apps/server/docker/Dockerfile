FROM python:3.11

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV POETRY_VIRTUALENVS_CREATE=false

# Set work directory
WORKDIR /code

# Install system-level build tools and netcat (for the entrypoint script)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential netcat-openbsd \
    && rm -rf /var/lib/apt/lists/*

# Install Poetry
RUN pip install --upgrade pip && pip install poetry==1.7.1

# Copy only the pyproject.toml to force a fresh dependency resolution
COPY pyproject.toml ./

# Install dependencies (this will be slow the first time)
RUN poetry install --no-interaction --no-ansi

# Copy the rest of the application code
COPY . .

# Expose the application's port
EXPOSE 4000

# Copy and set up the entrypoint script
COPY entrypoint.sh /app_entry/
RUN chmod +x /app_entry/entrypoint.sh
ENTRYPOINT ["/app_entry/entrypoint.sh"]