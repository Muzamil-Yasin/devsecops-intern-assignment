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