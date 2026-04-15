# Automated Multi-Tier Cloud Infrastructure on GCP 

This repository contains a professional-grade Infrastructure as Code (IaC) project using **Terraform** to deploy a highly available, containerized web application on Google Cloud Platform.

## Architecture Overview
The project implements a dual-VPC architecture with secure communication and automated traffic management:
- **Networking:** Two separate VPCs (Frontend & Backend) connected via **VPC Peering**.
- **Compute:** Managed Instance Groups (MIG) running **Dockerized Nginx** applications.
- **Traffic Management:** A Global **HTTP Load Balancer** acting as the single entry point.
- **Automation:** Fully automated deployment using Terraform providers and startup scripts.

##  Key Technologies
- **Terraform:** For infrastructure orchestration and state management.
- **Docker:** Containerization of frontend and backend services.
- **GCP Compute Engine:** Utilizing Instance Templates and Managed Groups.
- **Cloud Load Balancing:** Ensuring high availability and health checks.

##  Project Showcases

### 1. Live Web Portal
The final result showing the frontend engine successfully running inside a Docker container.
![Frontend Demo](frontend-live-demo.png)

### 2. Cloud Infrastructure Deployment
Confirmation of 17 resources successfully provisioned via Terraform Cloud Shell.
![Terraform Plan](terraform-plan.png)

### 3. Load Balancing Dashboard
The GCP Console showing the Global HTTP Load Balancer in a "Healthy" state, routing traffic to backend services.
![Load Balancer](load-balancer-dashboard.png)

### 4. Code Structure
Organized Terraform configuration files (`.tf`) for modularity and scalability.
![Project Structure](terraform-editor-structure.png)

##  How to Deploy
1. Clone the repository:
   ```bash
   git clone [https://github.com/Eng-waad/GPC-Terraform-Cloud-Forge.git](https://github.com/Eng-waad/GPC-Terraform-Cloud-Forge.git)
