#!/usr/bin/env python3
"""
Terraform Drift Detection Email Notification Script
Sends email notification about infrastructure drift detection status
"""

import smtplib
import ssl
import os
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from datetime import datetime

def get_env_variable(var_name, default=None):
    """Get environment variable with error handling"""
    value = os.environ.get(var_name, default)
    if value is None:
        raise ValueError(f"Environment variable '{var_name}' is not set")
    return value

def send_drift_detection_email():
    """Send drift detection notification email"""
    
    try:
        # Get email configuration from environment variables
        user_email = get_env_variable("USER_EMAIL")
        user_password = get_env_variable("USER_PASSWORD")
        smtp_server = get_env_variable("SMTP_SERVER", "smtp.gmail.com")
        smtp_port = int(get_env_variable("SMTP_PORT", "465"))
        recipient_email = get_env_variable("RECIPIENT_EMAIL", user_email)
        
        # Get GitHub context from environment
        github_repo = os.environ.get("GITHUB_REPOSITORY", "N/A")
        github_ref = os.environ.get("GITHUB_REF_NAME", "N/A")
        github_sha = os.environ.get("GITHUB_SHA", "N/A")
        github_actor = os.environ.get("GITHUB_ACTOR", "N/A")
        github_run_id = os.environ.get("GITHUB_RUN_ID", "N/A")
        github_server_url = os.environ.get("GITHUB_SERVER_URL", "https://github.com")
        
        # Create email message
        message = MIMEMultipart("alternative")
        message["Subject"] = f"✅ Terraform Drift Detection - {github_repo}"
        message["From"] = user_email
        message["To"] = recipient_email
        
        # Plain text version
        text_body = f"""
Terraform Drift Detection Report

Repository: {github_repo}
Branch: {github_ref}
Commit: {github_sha}
Triggered By: {github_actor}
Timestamp: {datetime.now().strftime('%Y-%m-%d %H:%M:%S UTC')}

Status: ✅ Drift Detection Completed

This is an automated notification from your Terraform drift detection workflow.
The infrastructure has been checked for configuration drift.

View the full workflow: {github_server_url}/{github_repo}/actions/runs/{github_run_id}

---
This is an automated message. Do not reply to this email.
"""
        
        # HTML version
        html_body = f"""
<html>
  <head>
    <style>
      body {{ font-family: Arial, sans-serif; line-height: 1.6; color: #333; }}
      .container {{ max-width: 600px; margin: 0 auto; padding: 20px; }}
      .header {{ background-color: #2c3e50; color: white; padding: 20px; border-radius: 5px; margin-bottom: 20px; }}
      .header h1 {{ margin: 0; font-size: 24px; }}
      .status {{ background-color: #d4edda; color: #155724; padding: 15px; border-radius: 5px; margin: 20px 0; }}
      .info {{ background-color: #f0f0f0; padding: 15px; border-radius: 5px; margin: 20px 0; }}
      .info-item {{ margin: 10px 0; }}
      .label {{ font-weight: bold; color: #2c3e50; }}
      .footer {{ margin-top: 30px; padding-top: 20px; border-top: 1px solid #ddd; font-size: 12px; color: #666; text-align: center; }}
      a {{ color: #3498db; text-decoration: none; }}
      a:hover {{ text-decoration: underline; }}
    </style>
  </head>
  <body>
    <div class="container">
      <div class="header">
        <h1>🔍 Terraform Drift Detection</h1>
        <p>Infrastructure Configuration Check</p>
      </div>

      <div class="status">
        <strong>✅ Status: Completed</strong>
        <p>The drift detection workflow has completed successfully.</p>
      </div>

      <div class="info">
        <h3>Workflow Details</h3>
        <div class="info-item">
          <span class="label">Repository:</span> {github_repo}
        </div>
        <div class="info-item">
          <span class="label">Branch:</span> {github_ref}
        </div>
        <div class="info-item">
          <span class="label">Commit:</span> <code>{github_sha[:8]}</code>
        </div>
        <div class="info-item">
          <span class="label">Triggered By:</span> {github_actor}
        </div>
        <div class="info-item">
          <span class="label">Timestamp:</span> {datetime.now().strftime('%Y-%m-%d %H:%M:%S UTC')}
        </div>
      </div>

      <div class="info">
        <p>
          <a href="{github_server_url}/{github_repo}/actions/runs/{github_run_id}">
            View Full Workflow Run →
          </a>
        </p>
      </div>

      <div class="footer">
        <p>This is an automated message from your Terraform drift detection workflow.</p>
        <p>Do not reply to this email.</p>
      </div>
    </div>
  </body>
</html>
"""
        
        # Attach both versions
        message.attach(MIMEText(text_body, "plain"))
        message.attach(MIMEText(html_body, "html"))
        
        # Send email
        print("📧 Connecting to SMTP server...")
        context = ssl.create_default_context()
        
        with smtplib.SMTP_SSL(smtp_server, smtp_port, context=context) as server:
            print(f"📧 Logging in as {user_email}...")
            server.login(user_email, user_password)
            
            print(f"📧 Sending email to {recipient_email}...")
            server.sendmail(user_email, recipient_email, message.as_string())
        
        print("✅ Email sent successfully!")
        return True
        
    except ValueError as e:
        print(f"❌ Configuration Error: {e}")
        exit(1)
    except smtplib.SMTPAuthenticationError:
        print("❌ SMTP Authentication failed. Check your email and password.")
        exit(1)
    except smtplib.SMTPException as e:
        print(f"❌ SMTP Error: {e}")
        exit(1)
    except Exception as e:
        print(f"❌ Unexpected error: {e}")
        exit(1)

if __name__ == "__main__":
    send_drift_detection_email()
