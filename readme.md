# MHN Ansible


Ansible Playbook to Provision the MHN Infrastructure

## Development

```bash
python3 -m pip install pipenv # Ensure Pipenv installed

pipenv install # Install Python packages into Venv

pipenv shell # Switch to Venv shell

molecule converge # (Will Create a VM and provision everything against it)
```

## Local Port forwarding.

When you setup a wildcard DNS entry for localhost using for example `dnsmasq`, you can use [forwardports.sh](molecule/default/forwardports.sh).
To forward the VM HTTP/HTTPS Ports to localhost `80` and `443`.

## Ansible Role Requirements

It may be required to manually install the required ansible roles and collections:

```bash
ansible-galaxy install -r requirements.yml
```

## Deploy with inventory.

First make sure you have your `Inventory.yml` ready. Example: [inventory.sample.yml](inventory.sample.yml)

```bash
ansible-playbook main.yml -i inventory.yml --extra-vars "ansible_sudo_pass=UserSudoPassword" # To work pass a Sudo password.
ansible-playbook main.yml -i inventory.yml --skip-tags update # Skip APT Updates
```

### Available Tags

- `update` -> Updates all APT packages to Latest