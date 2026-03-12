# Automated Security CI/CD Pipeline

A fully automated security pipeline integrating SAST, DAST, and secret scanning into CI/CD workflows using open-source tools.

## 🚀 Features

- **Secret Scanning**: TruffleHog for detecting hardcoded credentials
- **SAST**: SonarQube for static code analysis with quality gates
- **DAST**: OWASP ZAP for dynamic application security testing
- **Automated Gates**: Build breaks on security violations
- **Free & Open Source**: No licensing costs

## 📦 Prerequisites

- Docker & Docker Compose
- Git
- Jenkins or GitHub Actions

## 🛠️ Quick Start

1. **Clone and deploy infrastructure:**
```bash
git clone https://github.com/your-org/codefortess-ci.git
cd codefortess-ci
docker-compose up -d