# atl.sh — just recipes
# Run `just` to list available commands

default:
    @just --list

# Install Ansible collections and roles
install:
    ansible-galaxy install -r ansible/requirements.yml -p .ansible --force

# Terraform
tf-init:
    cd terraform && terraform init

tf-plan:
    cd terraform && terraform plan

tf-apply:
    cd terraform && terraform apply

# Deploy: dev (Docker), staging (Hetzner VPS), prod (physical)
deploy target:
    #!/usr/bin/env bash
    if [ "{{ target }}" = "dev" ]; then
        cd ansible && ansible-playbook site.yml -l dev --skip-tags security,env
    else
        cd ansible && ansible-playbook site.yml -l "{{ target }}"
    fi

deploy-tag target tag:
    #!/usr/bin/env bash
    if [ "{{ target }}" = "dev" ]; then
        cd ansible && ansible-playbook site.yml -l dev --tags "{{ tag }}" --skip-tags security,env
    else
        cd ansible && ansible-playbook site.yml -l "{{ target }}" --tags "{{ tag }}"
    fi

# User management (target: staging or prod)
create-user username key target:
    cd ansible && ansible-playbook playbooks/create-user.yml -e "username={{ username }}" -e "ssh_public_key='{{ key }}'" -e "target_hosts={{ target }}"

remove-user username target:
    cd ansible && ansible-playbook playbooks/remove-user.yml -e "username={{ username }}" -e "target_hosts={{ target }}"

# Development environment
dev-up:
    docker compose up -d

dev-down:
    docker compose down

# Quality
lint:
    pre-commit run --all-files

# Vault
vault-edit:
    ansible-vault edit ansible/inventory/group_vars/all/vault.yml
