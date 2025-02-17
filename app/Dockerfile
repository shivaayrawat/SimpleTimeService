# Use an ARM64-compatible Python base image
FROM --platform=linux/arm64 python:3.11-slim

# Set environment variables
ENV PYTHONUNBUFFERED=1

# Create a non-root user
RUN groupadd -r appgroup && useradd -r -g appgroup appuser

# Set working directory
WORKDIR /app

# Copy application files
COPY app.py /app/

# Install dependencies
RUN pip install --no-cache-dir flask requests

# Change ownership to non-root user
RUN chown -R appuser:appgroup /app

# Switch to non-root user
USER appuser

# Expose the application port
EXPOSE 5000

# Ensure Python is explicitly set to python3
CMD ["python3", "app.py"]
