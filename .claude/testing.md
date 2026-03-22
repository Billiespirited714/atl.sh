# Testing and local development

- Local dev: Vagrant + libvirt — `just dev-up`, then `just deploy dev`.
- Role tests: Molecule — `just molecule-test <role>`.
- Dev VM access requires `.ssh/dev_key` and `.ssh/dev_key.pub`.

For linting behavior (pre-commit vs ansible-lint), see [ansible.md](ansible.md).
