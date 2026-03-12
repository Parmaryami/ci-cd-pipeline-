#!/bin/bash
set -e

echo "🔍 Starting TruffleHog Secret Scanning..."

# Scan the entire git history
docker run --rm -v "$(pwd):/pwd" trufflesecurity/trufflehog:latest \
    git file:///pwd \
    --only-verified \
    --fail \
    --json | tee scan_results.json

# Check for high-confidence secrets
if jq -e 'select(.DetectorName | test("AWS|API|KEY|SECRET|TOKEN|PASSWORD"))' scan_results.json > /dev/null; then
    echo "❌ CRITICAL: High-value secrets detected!"
    echo "Found secrets:"
    jq -r '.DetectorName + ": " + .Redacted' scan_results.json
    exit 1
fi

echo "✅ No high-value secrets detected"