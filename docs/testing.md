# Local Development Environment (Vagrant)

Test Ansible playbooks locally using a Vagrant VM before deploying to staging/production.

## Environments

- **dev** (Vagrant): Local VM for Ansible testing
- **staging** (Terraform): Cloud instance for pre-production validation
- **production** (Terraform): Live system

## Prerequisites

- [Vagrant](https://www.vagrantup.com/)
- A virtualization provider: [vagrant-libvirt](https://github.com/vagrant-libvirt/vagrant-libvirt) (recommended on Linux) or [VirtualBox](https://www.virtualbox.org/)
- SSH key pair for dev access (create if missing):

```bash
mkdir -p .ssh
ssh-keygen -f .ssh/dev_key -t ed25519 -N ""
```

## Quick Start

```bash
# 1. Start the dev VM
just dev-up

# 2. Wait for provisioning (~30–60 seconds first run)
# Vagrant will download the box, boot the VM, and configure root SSH access

# 3. Test SSH connection
ssh -i .ssh/dev_key -p 2222 -o StrictHostKeyChecking=no root@127.0.0.1

# 4. Run Ansible playbook against dev VM
just deploy dev

# Or with check mode (dry run):
cd ansible && ansible-playbook site.yml -l dev --check --skip-tags security,env

# 5. Tear down when done
just dev-down
```

## Testing Specific Roles

```bash
cd ansible
ansible-playbook site.yml -l dev --tags common,packages
ansible-playbook site.yml -l dev --tags security -vvv
```

## Provider Notes

- **libvirt** (KVM): Default on most Linux. Install `vagrant-libvirt` and `libvirt`. Set `VAGRANT_DEFAULT_PROVIDER=libvirt` if needed.
- **VirtualBox**: Install VirtualBox and the Vagrant plugin. Set `VAGRANT_DEFAULT_PROVIDER=virtualbox` if needed.

## Troubleshooting

- **Plugin errors**: If Vagrant fails to initialize, try `vagrant plugin repair` or `vagrant plugin expunge --reinstall`
- **Provider not found**: Install `vagrant-libvirt` (Arch: `pacman -S vagrant libvirt`) or VirtualBox
- **Port 2222 in use**: Change the host port in the Vagrantfile and update `ansible_port` in `ansible/inventory/hosts.yml`

## Notes

- SSH key authentication using `.ssh/dev_key` (not committed to git)
- SSH available on `127.0.0.1:2222`
- VM uses Debian 12 (Bookworm); production uses Trixie — minor differences only
- Dev target skips `security` and `env` tags (sysctl, quotas) — test those on staging
- Native systemd — all Ansible tasks run as they would on staging/prod
