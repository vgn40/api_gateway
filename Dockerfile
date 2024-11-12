FROM python:3.9-slim

WORKDIR /app

# Create a volume for the SQLite database
RUN mkdir -p /app/data
VOLUME /app/data

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Ensure the database is created in the volume directory
ENV SQLITE_DB_PATH=/app/data/users.db

EXPOSE 5000

CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]
