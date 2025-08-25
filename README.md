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

Steps to Run the Project Locally:
1: Download and install the latest Node.js version on your system (Windows, Mac, or Linux)
2: Install Project Dependencies 
   Navigate to the project folder and install all required packages ( npm install )
3: Run ESLint for Code Quality Check 
   Make sure the following script exists in package.json under "scripts" ("lint": "eslint .") and then run "npm run lint"
4: Run Security Lint Check
   Ensure this script exists in package.json (""lint:security": "eslint --plugin security/recommended .") 
   and then npm run lint:security
5: Without yml we can run server using "node index.js/nodemon index.js" 
6: To check vulnerabilities after pushing to github(npm audit --audit-level=moderate) also for fixing vulnerabilities(npm audit fix)






##  DevSecOps Internship Project: CI/CD, Security, and Reverse-Engineering
During this internship task, I explored DevOps concepts and the SDLC, learning how security is integrated throughout the development process. I set up a Node.js project with ESLint and a security plugin, and configured GitHub Actions CI to automatically check code quality on every push or pull request. I also practiced reverse-engineering open-source DevOps projects to understand real-world deployment and security workflows.