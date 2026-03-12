#!/bin/bash
set -e

# Configuration
SONAR_HOST_URL="http://localhost:9000"
PROJECT_KEY="myapp"
PROJECT_NAME="My Application"

echo "🔧 Starting SonarQube SAST Analysis..."

# Run SonarScanner
docker run --rm \
    -e SONAR_HOST_URL="${SONAR_HOST_URL}" \
    -e SONAR_LOGIN="${SONAR_TOKEN}" \
    -v "$(pwd):/usr/src" \
    sonarsource/sonar-scanner-cli:latest \
    -Dsonar.projectKey=${PROJECT_KEY} \
    -Dsonar.projectName=${PROJECT_NAME} \
    -Dsonar.sources=. \
    -Dsonar.exclusions=**/node_modules/**,**/*.min.js \
    -Dsonar.tests=. \
    -Dsonar.test.inclusions=**/*test*/**

echo "✅ SAST Analysis Complete"

# Wait and check quality gate
sleep 30
python3 scripts/check-quality-gate.py