#!/bin/bash
echo "Checking for security violations..."

# Check for SQL injection patterns
if grep -q "executeQuery.*\+" src/main/java/*.java; then
    echo " CRITICAL: SQL Injection detected!"
    echo "Vulnerability: Concatenated SQL query found"
    exit 1
fi

# Check for hardcoded secrets
if grep -q '"[A-Za-z0-9_]{20,}"' src/main/java/*.java; then
    echo " CRITICAL: Hardcoded secret detected!"
    exit 1
fi

echo " Quality Gate PASSED"
exit 0
