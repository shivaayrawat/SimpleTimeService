# Use a lightweight Python base image
FROM python:3.11-slim

# Set environment variables
ENV PYTHONUNBUFFERED=1

# Create a non-root user
RUN groupadd -r appgroup && useradd -r -g appgroup appuser

# Set working directory
WORKDIR /app

# Copy application files
COPY app.py /app/

# Install Flask and requests
RUN pip install flask requests

# Change ownership to non-root user
RUN chown -R appuser:appgroup /app

# Switch to non-root user
USER appuser

# Expose the application port
EXPOSE 5000

# Run the application
CMD ["python", "app.py"]
