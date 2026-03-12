#!/usr/bin/env python3
import subprocess
import json
import sys
import time
import requests

def run_zap_scan(target_url, config_file='zap-baseline.config'):
    """
    Run OWASP ZAP active scan against target
    """
    print(f"🎯 Starting DAST Scan against {target_url}")
    
    cmd = [
        'docker', 'run', '--rm',
        '-v', f'{sys.path[0]}:/zap/wrk/:rw',
        '-t', 'ghcr.io/zaproxy/zaproxy:stable',
        'zap-baseline.py',
        '-t', target_url,
        '-c', config_file,
        '-r', 'zap-report.html',
        '-J', 'zap-report.json',
        '-a'  # Include alpha passive scanners
    ]
    
    try:
        result = subprocess.run(cmd, capture_output=True, text=True)
        
        if result.returncode != 0:
            print(f"⚠️  ZAP Scan completed with warnings")
        
        # Parse JSON report
        with open('zap-report.json', 'r') as f:
            report = json.load(f)
        
        # Check for critical/high vulnerabilities
        high_risk = report.get('High', 0)
        medium_risk = report.get('Medium', 0)
        
        print(f"📊 Scan Results:")
        print(f"   High Risk: {high_risk}")
        print(f"   Medium Risk: {medium_risk}")
        
        # Fail build if high-risk vulnerabilities found
        if high_risk > 0:
            print("❌ BUILD FAILED: High-risk vulnerabilities detected")
            sys.exit(1)
            
    except Exception as e:
        print(f"❌ DAST Scan failed: {e}")
        sys.exit(1)

if __name__ == "__main__":
    # Target staging environment
    target = sys.argv[1] if len(sys.argv) > 1 else "http://staging-app:8080"
    run_zap_scan(target)