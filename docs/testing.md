# Local Development Environment (Vagrant)

Test Ansible playbooks locally using a Vagrant VM before deploying to staging/production.

## Environments

- **dev** (Vagrant): Local VM for Ansible testing
- **staging** (Terraform): Cloud instance for pre-production validation
- **production** (Terraform): Live system

## Prerequisites

- [Vagrant](https://www.vagrantup.com/)
- [vagrant-libvirt](https://github.com/vagrant-libvirt/vagrant-libvirt) + libvirt (KVM) — required; the Debian Trixie box does not support VirtualBox
- SSH key pair for dev access (create if missing):

```bash
mkdir -p .ssh
ssh-keygen -f .ssh/dev_key -t ed25519 -N ""
```

## Setup

### Arch Linux

**1. Install libvirt and QEMU**

```bash
sudo pacman -S libvirt qemu-base dnsmasq openbsd-netcat bridge-utils
```

**2. Add your user to the libvirt group**

```bash
sudo usermod -aG libvirt $(whoami)
```

Log out and back in (or run `newgrp libvirt`) for the group change to take effect.

**3. Enable and start libvirtd**

```bash
sudo systemctl enable --now libvirtd
```

**4. Verify libvirt**

```bash
virsh list --all
```

Should run without sudo and show an empty list (or existing VMs).

**5. Install Vagrant**

```bash
sudo pacman -S vagrant
```

**6. Install vagrant-libvirt plugin**

If you have `iptables` installed, remove it first (Arch uses `iptables-nft`):

```bash
sudo pacman -S iptables-nft pkg-config gcc make ruby
# If iptables exists: sudo pacman -Rns iptables  # remove conflicting package
vagrant plugin install vagrant-libvirt
```

**7. Provider**

`just dev-up` sets `VAGRANT_DEFAULT_PROVIDER=libvirt` automatically. If running `vagrant` directly, set `export VAGRANT_DEFAULT_PROVIDER=libvirt`.

### Other distros

- [Ubuntu/Debian](https://vagrant-libvirt.github.io/vagrant-libvirt/installation.html#ubuntu--debian)
- [Fedora](https://vagrant-libvirt.github.io/vagrant-libvirt/installation.html#fedora)
- [ArchWiki: libvirt](https://wiki.archlinux.org/title/libvirt)

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
cd ansible && ansible-playbook site.yml -l dev --check

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

The `debian/trixie64` box supports only **libvirt** (KVM). If Vagrant picks VirtualBox by default, set `export VAGRANT_DEFAULT_PROVIDER=libvirt` before `just dev-up`.

## Troubleshooting

- **Provider mismatch / wrong VM state**: If you previously used VirtualBox or have stale state, remove `.vagrant` and re-run `just dev-up`:
  ```bash
  rm -rf .vagrant
  just dev-up
  ```
- **Plugin errors**: If Vagrant fails to initialize, try `vagrant plugin repair` or `vagrant plugin expunge --reinstall`
- **Provider not found**: Install `vagrant-libvirt` (Arch: `pacman -S vagrant libvirt`)
- **Port 2222 in use**: Change the host port in the Vagrantfile and update `ansible_port` in `ansible/inventory/hosts.yml`
- **libvirt `virNetworkCreate` / `guest_nat` nftables error**: The default libvirt NAT network can conflict with nftables on Arch. Try:

  1. Flush leftover libvirt nftables tables:
     ```bash
     sudo nft delete table ip libvirt_network 2>/dev/null
     sudo nft delete table ip6 libvirt_network 2>/dev/null
     ```

  2. Reset the default network:
     ```bash
     sudo virsh net-destroy default 2>/dev/null || true
     sudo virsh net-undefine default
     sudo systemctl restart libvirtd
     ```
     (libvirt recreates the default network on next `vagrant up`)

  3. If that fails, try forcing libvirt to use iptables — create `/etc/libvirt/network.conf` with `firewall_backend='iptables'`, then restart libvirtd. **Note**: Zen kernel lacks iptables modules; this workaround will not work on Arch with Zen. Use steps 1–2 instead.

## Notes

- SSH key authentication using `.ssh/dev_key` (not committed to git)
- SSH available on `127.0.0.1:2222`
- VM uses Debian 13 (Trixie) to match production
- Dev target runs full playbook including security and quotas
- Native systemd — all Ansible tasks run as they would on staging/prod
