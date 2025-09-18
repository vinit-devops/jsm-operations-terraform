# JSM Operations Terraform Modules

This repository (`jsm-operations-terraform`) contains Terraform modules for managing **Jira Service Management (JSM) Operations** resources in a consistent and automated way.  

The modules centralize configuration for **teams, integrations, alert policies, and notification policies**, ensuring governance and reusability across environments.

---

## 📌 Available Modules

- **[`team`](./team)** → Create and manage JSM Ops teams and their members  
- **[`alert_policy`](./alert_policy)** → Define and manage global alert policies  
- **[`notification_policy`](./notification_policy)** → Configure user/team notification rules  
- **[`api_integration`](./api_integration)** → Manage API integrations  
- **[`email_integration`](./email_integration)** → Manage email integrations  
- **[`integration_action`](./integration_action)** → Define integration actions (e.g., webhook, automation triggers)

---

## 🔧 Requirements
- Terraform >= 1.5.0
- Atlassian Terraform Provider
- Valid JSM Ops API Key with required permissions

## 📖 Documentation
- Terraform Provider: Atlassian Operations
- JSM Ops Documentation

