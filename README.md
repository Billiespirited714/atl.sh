# atl.sh

Public UNIX environment for the All Things Linux community.

atl.sh is a shared system providing shell access, web hosting, and alternative protocol services (Gemini, Gopher) for community members.

## Features

- **Shell Access**: SSH environment with standard CLI tools (Vim, Neovim, Tmux, Git).
- **Web Hosting**: Static hosting at `https://atl.sh/~username` via Nginx.
- **Alternative Protocols**: Project hosting via Gemini (`gemini://atl.sh/~username`) and Gopher (`gopher://atl.sh/~username`).
- **Development**: Toolchains available for C, C++, Python, Node.js, Go, Rust, Ruby and more.
- **Isolation**: Resource management and user isolation using Cgroups v2 and systemd-slices.

## Tech Stack

| Component | Technology |
| :--- | :--- |
| OS | Debian 13 (Trixie) |
| Configuration | Ansible |
| Infrastructure | Terraform (Hetzner, Cloudflare) |
| Web Server | Nginx |
| Gemini / Gopher | molly-brown, Gophernicus |
| FTP | vsftpd |
| Backups | Borgmatic |
| Monitoring | prometheus-node-exporter, smartmontools |
| Logging | logrotate, journald |
| Security | UFW, Fail2ban, Auditd, user slices |

## Security and Isolation

The system implements multiple layers of protection to ensure stability for all users:

- **CIS Hardening**: Implements CIS Level 2 benchmark controls including kernel hardening (ASLR, ptrace restrictions), network protections (SYN cookies, anti-spoofing), and module blacklisting.
- **Resource Limits**: systemd user slices enforce kernel-level caps on CPU, memory, and process count per user.
- **Hardened /tmp**: User-specific temporary directories are mounted as `tmpfs` with `nodev`, `nosuid`, and `noexec` options.
- **Quotas**: User and group filesystem quotas are enforced on the root partition.
- **Network**: SSH is rate-limited and protected by Fail2ban with strong cryptographic ciphers.
- **Monitoring**: AIDE file integrity monitoring, enhanced auditd logging, and automatic security updates.

## Development

### Local Development Environment

A Docker-based development environment is provided for testing Ansible playbooks locally:

```bash
# Start development container
docker compose up -d

# Run Ansible playbook against dev container
cd ansible
ansible-playbook -i inventory/dev.ini site.yml --skip-tags security,env

# SSH into dev container
ssh -p 2222 -i .ssh/dev_key root@localhost
```

The development container:
- Runs Debian Trixie with systemd
- Uses safe resource limits (4GB RAM, 4 CPUs, 2048 PIDs)
- Mounts Ansible playbooks read-only for testing
- Skips security hardening (sysctl) and quotas (not supported in containers)

### Prerequisites

Install necessary Ansible collections:
```bash
ansible-galaxy install -r requirements.yml
```

## Deployment

### Infrastructure Provisioning

```bash
cd terraform
terraform init
terraform apply
```

### Configuration Management

```bash
cd ansible

# Full deployment
ansible-playbook site.yml

# Specific roles
ansible-playbook site.yml --tags common,packages,users
```

### Quality Control

Pre-commit hooks are used to maintain code quality:
```bash
pre-commit install
pre-commit run --all-files
```

## Documentation

- [User Guide](docs/user-guide.md)
- [Admin Guide](docs/admin-guide.md)
- [Architecture](docs/architecture.md)
- [Testing Guide](docs/testing.md)
