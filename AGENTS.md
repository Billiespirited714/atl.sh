# AGENTS.md

## Project Overview

atl.sh is a public Unix environment (pubnix) for the All Things Linux community. Users get shell accounts, host personal websites (HTTP, Gemini, Gopher), and connect via finger, FTP, and IRC. The server runs Debian 13 (Trixie), configured entirely through Ansible, with infrastructure provisioned via Terraform.

## Repository Structure

```
ansible/           Playbooks, inventory, roles, and ansible.cfg
ansible/site.yml   Main playbook — roles run in order listed here
ansible/roles/     9 roles: common, packages, security, users, environment, services, ftp, monitoring, backup
ansible/playbooks/ Standalone playbooks (create-user.yml, remove-user.yml)
ansible/inventory/ hosts.yml (dev/staging/prod), group_vars/
terraform/         Hetzner Cloud + Cloudflare (staging infra)
docs/              Fumadocs site (Next.js, deployed to Cloudflare Workers)
skel/              Template files copied to new user home directories
justfile           Task runner — run `just` to list all commands
```

## Environments

| Target    | Description                          | SSH                                      |
|-----------|--------------------------------------|------------------------------------------|
| `dev`     | Local Vagrant VM (libvirt)           | `ssh -p 2223 -i .ssh/dev_key root@127.0.0.1` |
| `staging` | Hetzner Cloud VPS (Terraform-managed)| `ssh root@staging.atl.sh`                |
| `prod`    | Physical Hetzner dedicated server    | `ssh root@atl.sh`                        |

## Key Commands

```bash
just deploy dev          # Full Ansible run against dev VM
just deploy-tag prod services  # Deploy only the services role to prod
just create-user <name> '<ssh-ed25519 ...>' prod
just remove-user <name> prod
just lint                # pre-commit + ansible-lint (separate steps)
just syntax-check        # ansible-playbook --syntax-check only
just molecule-test <role>  # Full Molecule test lifecycle for a role
```

## Ansible Conventions

- All tasks use fully qualified collection names (`ansible.builtin.*`, `community.general.*`, `ansible.posix.*`)
- Handler names are capitalized (e.g., `Restart sshd`, `Reload nginx`)
- Variables are defined in `group_vars/all/` — secrets live in `vault.yml` (encrypted, edit with `just vault-edit`)
- Galaxy roles/collections are declared in `ansible/requirements.yml` and installed to `.ansible/` (gitignored)
- The `.ansible-lint` config uses `offline: true` and skips `var-naming[no-role-prefix]` and `name[casing]`

## Ansible Role Order

Roles execute in this order (defined in `ansible/site.yml`):

1. **common** — apt cache, base packages, NTP, journald, logrotate
2. **packages** — shells, languages, editors, CLI tools, games packages
3. **security** — kernel hardening, SSH, firewall, fail2ban, auditd, AIDE, unattended-upgrades
4. **users** — skel files, MOTD, PAM limits, systemd user slices
5. **environment** — cgroup limits, disk quotas, private /tmp, XDG dirs, PATH
6. **services** — nginx, gemini (molly-brown), gopher (gophernicus), finger (efingerd), webring, games
7. **ftp** — vsftpd (explicit FTP over TLS)
8. **monitoring** — prometheus node exporter, smartmontools, lm-sensors
9. **backup** — borgmatic (borgbackup)

## Linting

ansible-lint runs outside of pre-commit due to known hanging issues with pre-commit 4.x + ansible-lint v26. `just lint` runs pre-commit first, then ansible-lint as a separate step.

## Sensitive Files (Do Not Commit)

- `ansible/inventory/group_vars/all/vault.yml` — Ansible vault (encrypted secrets)
- `terraform/terraform.tfvars` — Terraform variables with API tokens
- `.ssh/dev_key` / `.ssh/dev_key.pub` — Dev VM SSH keys
- All listed in `.gitignore`

## Testing

- Local dev uses Vagrant + libvirt (`just dev-up`, `just deploy dev`)
- Role-level testing uses Molecule (`just molecule-test <role>`)
- Requires `.ssh/dev_key` and `.ssh/dev_key.pub` for dev VM access

## Tech Stack

| Component       | Technology                              |
|-----------------|-----------------------------------------|
| OS              | Debian 13 (Trixie)                      |
| Config mgmt     | Ansible (ansible-core 2.20+)            |
| Infrastructure  | Terraform (Hetzner Cloud, Cloudflare)   |
| Web server      | Nginx + fcgiwrap                        |
| Gemini          | molly-brown                             |
| Gopher          | Gophernicus                             |
| Finger          | efingerd (systemd socket-activated)     |
| FTP             | vsftpd                                  |
| Backups         | Borgmatic (BorgBackup)                  |
| Monitoring      | Prometheus Node Exporter                |
| Docs            | Fumadocs (Next.js → Cloudflare Workers) |
