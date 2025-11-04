# DevSecOps Intern Assignment

A Node.js web application demonstrating a full CI/CD pipeline with security integration on AWS.



## Architecture & CI/CD Flow

### Source Stage
- Code hosted on GitHub
- AWS CodePipeline detects changes automatically

### Build Stage
- AWS CodeBuild builds Docker image
- Pushes image to Amazon ECR
- Generates `imagedefinitions.json` for deployment

### Deploy Stage
- AWS CodeDeploy pulls latest image from ECR
- Uses `appspec.yml` + deployment scripts (`start.sh`, `stop.sh`, `healthsscript.sh`)
- Performs health checks and rollback on failure



## Tools & Technologies
- Node.js – Application framework
- Docker – Containerization
- Amazon ECR – Docker image registry
- AWS CodePipeline – CI/CD automation
- AWS CodeBuild – Build stage
- AWS CodeDeploy (EC2) – Deployment with `appspec.yml` and scripts


## Important Files
- **Dockerfile** → Containerization of Node.js app
- **buildspec.yml** → AWS CodeBuild instructions
- **appspec.yml** → AWS CodeDeploy instructions
- **scripts/** → Deployment scripts (`start.sh`, `stop.sh`, `healthsscript.sh`)

## Outcome
Successfully deployed a Node.js application using GitHub → AWS CI/CD pipeline with Docker and EC2, including automated health checks, rollbacks, and security validation.


## Outcome
Successfully deployed a Node.js application using GitHub → AWS CI/CD pipeline with Docker and EC2, including automated health checks, rollbacks, and security validation.
