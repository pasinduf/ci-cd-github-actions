# Full CI/CD with GitHub Actions + Docker + VPS

This repository demonstrates a modern **full CI/CD pipeline** using **GitHub Actions** and **Docker** to deploy a Node.js application to a VPS.

## Overview

- Push code to GitHub → triggers GitHub Actions
- Build Docker image using multi-stage Dockerfile
- Push image to GHCR (GitHub Container Registry)
- SSH into VPS → stop old container → run new container
- Environment variables stored in `.env` on VPS

## Prerequisites

- VPS with Docker installed
- SSH access to VPS
- `.env` file on VPS with secret keys
- GitHub repository with Actions enabled
- GHCR access (optional)

## Steps

1. **Generate SERVER_SSH_KEY for VPS access**
  - In server run
    ssh-keygen -t ed25519 -C "github-deploy"

  - This generates two files in ~/.ssh/ folder:
    ed25519 → private key (SERVER_SSH_KEY)
    ed25519.pub → public key

  - Add the public key to your VPS user’s ~/.ssh/authorized_keys file
  - Store the private key as GitHub Actions secret: SERVER_SSH_KEY (Repo → Settings → Secrets → Actions)
  - GitHub Actions can now SSH into VPS securely without password

2. **GitHub Actions Workflow**

   Workflow file: `.github/workflows/deploy.yml`

   - Checkout code
   - Install dependencies
   - Run tests
   - Build Docker image
   - Push to GHCR
   - SSH into VPS → deploy container

3. **Environment Variables**

   - Create `.env` file on VPS
   - Include DB credentials, secrets, and NODE_ENV
   - Example: `.env.example` provided

4. **Deployment**
   - Run container on VPS with specified port


## Notes

- Ensure VPS has Docker installed
- Use `.env` files securely
- Save all necessary secrets in Git Repo secrets (Repo → Settings → Secrets → Actions → New repository secret) 