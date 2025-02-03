# SimpleTimeService

## SimpleTimeService - A Simple Microservice in Python

### Purpose
The **SimpleTimeService** is a lightweight microservice built using Flask. It returns a JSON response that includes:
- **IP address of the client making the request**
- **Current timestamp**

This service is built as a Docker container to ensure easy deployment across different environments.

---

## Prerequisites

Before you begin, ensure that you have the following tools installed:

### 1. **Docker**
Docker is needed to build, run, and manage containers.
- **Installation Guide**: [Docker Installation](https://docs.docker.com/get-docker/)
- Verify installation:
  ```sh
  docker --version
  ```

### 2. **Git**
Git is needed to clone the repository to your local machine.
- **Installation Guide**: [Git Installation](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- Verify installation:
  ```sh
  git --version
  ```

---

## Clone the Repository
To get started, clone the repository to your local machine:
```sh
git clone https://github.com/shivaayrawat/SimpleTimeService.git
```
Navigate into the project directory:
```sh
cd SimpleTimeService
```

---

## Build the Docker Image
Once you've cloned the repository, you can build the Docker image using the following command:
```sh
docker build -t simple-time-service .
```
- `-t simple-time-service` tags the image with the name `simple-time-service`.
- This command may take a few minutes as it pulls the necessary dependencies.

---

## Run the Docker Container
Once the image is built, you can run the Docker container. This will start the application on port `5000`.

To run the container in the background:
```sh
docker run -d -p 5000:5000 simple-time-service
```
- `-d` runs the container in **detached mode** (in the background).
- `-p 5000:5000` binds **port 5000** of the container to **port 5000** on your local machine.

---

## Access the Application
After the container is running, you can access the **SimpleTimeService** by navigating to the following URL in your web browser:

📌 **URL:** [http://localhost:5000](http://localhost:5000)

The response will be a JSON object that includes the timestamp and IP address of the client:
```json
{
  "ip": "160.191.123.133",
  "timestamp": "2025-01-31T14:45:00.123456"
}
```

---

## Stopping the Container
To stop the running container, use the following command to find the container ID:
```sh
docker ps
```
This will display the currently running containers. Look for the container with the image name **simple-time-service**, and note the container ID.

Stop the container with:
```sh
docker stop <container_id>
```
Replace `<container_id>` with the actual container ID.

---

## DockerHub Image
The **SimpleTimeService** Docker image has been published to **DockerHub**. You can pull the latest version directly from DockerHub by using the following command:
```sh
docker pull 945shivamrawat/simple-time-service:latest
```

---

### 🎉 Now your **SimpleTimeService** is ready to use!

