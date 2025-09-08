# DevSecOps Intern Assignment

This is a simple web application for demonstrating a CI/CD pipeline with security integration.

## 📌 Purpose
- Learn the basics of DevOps and DevSecOps.
- Set up a GitHub Actions CI/CD pipeline.
- Integrate security checks in the pipeline.

##  How to Run Locally
1. Clone the repo:
   ```bash
   git clone https://github.com/Muzamil-Yasin/devsecops-intern-assignment.git
   cd devsecops-intern-assignment

## 🚀 Steps to Run the Project Locally

1. **Download and Install Node.js**  
   - Install the latest version of Node.js on your system (Windows, Mac, or Linux).  

2. **Install Project Dependencies**  
   - Navigate to the project folder.  
   - Run:  
     ```bash
     npm install
     ```

3. **Run ESLint for Code Quality Check**  
   - Ensure this script exists in `package.json` under `"scripts"`:  
     ```json
     "lint": "eslint ."
     ```
   - Then run:  
     ```bash
     npm run lint
     ```

4. **Run Security Lint Check**  
   - Ensure this script exists in `package.json`:  
     ```json
     "lint:security": "eslint --plugin security/recommended ."
     ```
   - Then run:  
     ```bash
     npm run lint:security
     ```

5. **Run the Server (Without YAML)**  
   - You can start the server using:  
     ```bash
     node index.js
     ```
     or  
     ```bash
     nodemon index.js
     ```

6. **Check and Fix Vulnerabilities**  
   - After pushing to GitHub, check vulnerabilities:  
     ```bash
     npm audit --audit-level=moderate
     ```
   - To fix vulnerabilities automatically:  
     ```bash
     npm audit fix
     ```






##  DevSecOps Internship Project: CI/CD, Security, and Reverse-Engineering
During this internship task, I explored DevOps concepts and the SDLC, learning how security is integrated throughout the development process. I set up a Node.js project with ESLint and a security plugin, and configured GitHub Actions CI to automatically check code quality on every push or pull request. I also practiced reverse-engineering open-source DevOps projects to understand real-world deployment and security workflows.





                 My Node.js Project with AWS CI/CD
📌 Overview

This is a Node.js application deployed on AWS using a fully automated CI/CD pipeline.
The pipeline ensures that every code change pushed to GitHub is automatically built, tested, and deployed to AWS.

⚙️ Architecture

# The deployment pipeline consists of three main stages:

# Source 🟢

# Source code is hosted on GitHub.

# AWS CodePipeline automatically detects changes (via webhooks) when I push code.

# Build 🟡

# AWS CodeBuild is used to:

# Build a Docker image of the app.

# Push the Docker image to Amazon ECR.

# Generate imagedefinitions.json for deployment.

# Deploy 🔵

# AWS CodeDeploy (with ECS/EC2) pulls the latest image from ECR.

# Deployment is handled via appspec.yml + scripts to ensure smooth rollouts.



# Tech Stack

# Node.js – Application framework

# Docker – Containerization

# Amazon ECR – Image registry

# AWS CodePipeline – CI/CD automation
 
# AWS CodeBuild – Build stage

# AWS CodeDeploy + ECS/EC2 – Deployment



 # Important Files

# Dockerfile → Defines how the Node.js app is containerized.

# buildspec.yml → Build instructions for AWS CodeBuild.

# appspec.yml → Deployment instructions for AWS CodeDeploy.

# scripts/ → Helper scripts for deployment (start/stop/install, etc.).