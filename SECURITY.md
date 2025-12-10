# Security Policy

## Supported Versions

We actively maintain and provide security updates for the following versions:

| Version | Supported          |
| ------- | ------------------ |
| 9.5.x   | :white_check_mark: |
| 9.4.x   | :white_check_mark: |
| < 9.4   | :x:                |

## Reporting a Vulnerability

We take security vulnerabilities seriously. If you discover a security issue in this project, please report it responsibly.

### How to Report

**Please do NOT report security vulnerabilities through public GitHub issues.**

Instead, please report security vulnerabilities by:

1. **Email**: Send details to the repository maintainer via GitHub email
2. **GitHub Security Advisories**: Use the [GitHub Security Advisory](https://github.com/Rballesteros/menubar/security/advisories/new) feature (preferred)

### What to Include

When reporting a vulnerability, please include:

- Description of the vulnerability
- Steps to reproduce the issue
- Potential impact of the vulnerability
- Any suggested fixes or mitigations (if applicable)
- Your contact information for follow-up

### Response Timeline

- **Initial Response**: Within 48 hours of report
- **Status Update**: Within 7 days with assessment
- **Fix Timeline**: Varies based on severity, typically within 30 days for high-severity issues

### Disclosure Policy

- We request that you do not publicly disclose the vulnerability until we've had a chance to address it
- We will credit you in the security advisory (unless you prefer to remain anonymous)
- Once a fix is released, we will publish a security advisory with details

## Security Best Practices

When using this library:

- Always use the latest stable version
- Keep Electron updated to the latest version
- Follow [Electron security best practices](https://www.electronjs.org/docs/latest/tutorial/security)
- Enable context isolation in your BrowserWindow configuration
- Use a Content Security Policy (CSP)
- Validate and sanitize all user input

## Dependencies

This project has minimal dependencies to reduce the attack surface:

- `electron-positioner` - Position calculation utility
- Development dependencies are regularly updated for security patches

## Attribution

This security policy is adapted from the [Contributor Covenant](https://www.contributor-covenant.org/) and industry best practices.
