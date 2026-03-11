# atl.sh — just recipes
# Run `just` to list available commands

# List all available recipes
default:
    @just --list

# Install Ansible collections and roles (separate commands per Ansible docs)
# Roles: .ansible/roles/; Collections: .ansible/collections/ansible_collections/
# Paths use justfile_directory() so install location is correct regardless of cwd

[private]
_ansible := justfile_directory() + "/.ansible"
[private]
_ansible_dir := justfile_directory() + "/ansible"

install:
    cd {{ _ansible_dir }} && ansible-galaxy role install -r requirements.yml -p {{ _ansible }}/roles --force
    cd {{ _ansible_dir }} && ansible-galaxy collection install -r requirements.yml -p {{ _ansible }}/collections --force

# Terraform — initialize backend and providers
tf-init:
    cd terraform && terraform init

# Terraform — show planned changes
tf-plan:
    cd terraform && terraform plan

# Terraform — apply changes to infrastructure
tf-apply:
    cd terraform && terraform apply

# Deploy: dev (Vagrant VM), staging (Hetzner VPS), prod (physical)
deploy target:
    cd ansible && ansible-playbook site.yml -l "{{ target }}"

# Deploy specific roles by tag (e.g. common,packages,users)
deploy-tag target tag:
    cd ansible && ansible-playbook site.yml -l "{{ target }}" --tags "{{ tag }}"

# Create pubnix user account (target: staging or prod)
create-user username key target:
    cd ansible && ansible-playbook playbooks/create-user.yml -e "username={{ username }}" -e "ssh_public_key='{{ key }}'" -e "target_hosts={{ target }}"

# Remove pubnix user account (target: staging or prod)
remove-user username target:
    cd ansible && ansible-playbook playbooks/remove-user.yml -e "username={{ username }}" -e "target_hosts={{ target }}"

# Verify dev prerequisites (.ssh/dev_key, .ssh/dev_key.pub) before dev-up
dev-check:
    #!/usr/bin/env bash
    if [ ! -f .ssh/dev_key ] || [ ! -f .ssh/dev_key.pub ]; then
        echo "Missing .ssh/dev_key or .ssh/dev_key.pub"
        echo "Create with: mkdir -p .ssh && ssh-keygen -f .ssh/dev_key -t ed25519 -N \"\""
        exit 1
    fi
    echo "Dev prerequisites OK"

# Development environment (Vagrant + libvirt; requires .ssh/dev_key.pub)
dev-up:
    just dev-check
    VAGRANT_DEFAULT_PROVIDER=libvirt vagrant up

# Halt dev VM
dev-down:
    vagrant halt

# Run pre-commit hooks on all files
lint:
    pre-commit run --all-files

# Edit Ansible vault (secrets)
vault-edit:
    ansible-vault edit ansible/inventory/group_vars/all/vault.yml
