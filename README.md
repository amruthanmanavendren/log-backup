# Django Log Backup System

## Overview

This project is a **Django-based web application** designed to demonstrate a **production-ready deployment using Docker, PostgreSQL, and Nginx**.
It also includes a **CI/CD pipeline using GitHub Actions** and can be deployed to an AWS EC2 instance.

The system focuses on running a Django application in a **containerized environment** and managing logs while ensuring scalable deployment.

---

## Project Architecture

User Request → Nginx → Django (Gunicorn) → PostgreSQL Database

Components:

* **Nginx**

  * Acts as a reverse proxy
  * Handles incoming HTTP requests
  * Forwards requests to Django application

* **Django**

  * Backend application framework
  * Runs using Gunicorn for production
  * Handles business logic and database operations

* **PostgreSQL**

  * Relational database
  * Stores application data

* **Docker**

  * Containerizes the application
  * Ensures consistent environments across systems

* **Docker Compose**

  * Orchestrates multiple containers
  * Manages networking between services

* **GitHub Actions**

  * Automates CI/CD pipeline
  * Deploys updates automatically to AWS EC2

---

## Technologies Used

* Python
* Django
* PostgreSQL
* Docker
* Docker Compose
* Nginx
* GitHub Actions
* AWS EC2

---

## Project Structure

```
log-backup/
│
├── config/                 # Django project configuration
├── Dockerfile              # Docker image configuration
├── docker-compose.yml      # Multi-container setup
├── requirements.txt        # Python dependencies
├── manage.py               # Django management script
├── nginx/
│   └── nginx.conf          # Nginx reverse proxy configuration
├── .github/
│   └── workflows/
│       └── deploy.yml      # CI/CD pipeline
└── README.md
```

---

## How the System Works

1. A user sends a request to the server.
2. **Nginx** receives the request on port 80.
3. Nginx forwards the request to the Django container.
4. Django processes the request using **Gunicorn**.
5. If data is required, Django communicates with **PostgreSQL**.
6. The response is returned back to the user through Nginx.

---

## Installation (Local Setup)

### 1. Clone the Repository

```
git clone https://github.com/your-username/log-backup.git
cd log-backup
```

### 2. Install Docker and Docker Compose

```
sudo apt update
sudo apt install docker.io docker-compose -y
```

### 3. Run Containers

```
docker-compose up --build
```

### 4. Access the Application

Open your browser:

```
http://localhost
```

---

## Running Migrations

Django migrations run automatically when the container starts.

You can also run manually:

```
docker-compose exec web python manage.py migrate
```

---

## Deployment (AWS EC2)

### Steps

1. Launch an EC2 instance
2. Install Docker and Git
3. Clone the repository
4. Run Docker Compose

Example:

```
git clone https://github.com/your-username/log-backup.git
cd log-backup
docker-compose up --build -d
```

Make sure your **Security Group allows port 80**.

Then access:

```
http://EC2-PUBLIC-IP
```

---
## AWS IAM User Setup (Required for AWS CLI)

This project uses **AWS CLI** to interact with AWS services (for example uploading logs to an S3 bucket).
Before running the project on an EC2 instance, an **IAM user with proper permissions** must be created.

### Step 1: Create IAM User

1. Go to AWS Console
2. Open **IAM → Users**
3. Click **Create User**
4. Give a username (example: `django-log-user`)
5. Select **Programmatic access**

### Step 2: Attach Permissions

Attach the required policy:

* AmazonS3FullAccess *(or a custom S3 policy for better security)*

### Step 3: Download Access Keys

After creating the user you will receive:

* **Access Key ID**
* **Secret Access Key**

Save these credentials securely.

### Step 4: Configure AWS CLI on Server

On the EC2 server run:

```
aws configure
```

Enter the following:

```
AWS Access Key ID: <your-access-key>
AWS Secret Access Key: <your-secret-key>
Default region: us-east-1
Output format: json
```

This will store credentials inside:

```
~/.aws/credentials
```

### Step 5: Verify AWS CLI

Run:

```
aws s3 ls
```

If configured correctly, it will display your S3 buckets.

### Security Note

Never commit AWS credentials to GitHub.
Always configure them directly on the server using `aws configure`.

---
## CI/CD Pipeline

This project uses **GitHub Actions** for automated deployment.

Workflow:

1. Developer pushes code to GitHub.
2. GitHub Actions triggers the pipeline.
3. The EC2 server pulls the latest code.
4. Containers are rebuilt and restarted automatically.

---

## Logging

Application logs are stored inside:

```
/var/log/myapp/
```

These logs can be backed up or uploaded to services like **AWS S3**.

---

## Key DevOps Features

* Containerized application using Docker
* Multi-container architecture using Docker Compose
* Reverse proxy with Nginx
* PostgreSQL database container
* Automated migrations during container startup
* CI/CD deployment with GitHub Actions
* Cloud deployment on AWS EC2

---

## Future Improvements

* Add Redis caching
* Add Celery for background tasks
* Store logs in AWS S3
* Add HTTPS with Let's Encrypt
* Add monitoring with Prometheus & Grafana

---

## Author

Amrutha N Manavendren

Backend Developer | Python | Django | DevOps Enthusiast
