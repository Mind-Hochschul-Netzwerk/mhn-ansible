# MHN Ansible


[Ansible Playbook](https://docs.ansible.com/ansible/latest/user_guide/playbooks_intro.html)  configure the MHN Infrastructure.

## Development

All python dependencies can be installed using [pipenv](https://pypi.org/project/pipenv/).

For local testing, you can use [vagrant](https://www.vagrantup.com/) with [Ansible-Molecule](https://molecule.readthedocs.io/en/latest/) to create a local VM and provision it.

```bash
python3 -m pip install pipenv #Ensure Pipenv installed

pipenv install #Install Python packages into Venv

pipenv shell #Switch to Venv shell

molecule converge #Will Create a local VM and provision everything against it
```

### Ansible Role Requirements

It may be required to manually install the required ansible roles and collections:

```bash
ansible-galaxy install -r requirements.yml
```

### Local Port forwarding

When you setup a wildcard DNS entry for localhost using for example `dnsmasq`, you can use [forwardports.sh](molecule/default/forwardports.sh).
To forward the VM HTTP/HTTPS Ports to localhost `80` and `443`.

## Deploy to remote machine

First make sure you have your `Inventory.yml` ready. See example: [inventory.sample.yml](inventory.sample.yml)

```bash
ansible-playbook main.yml -i inventory.yml --extra-vars "ansible_sudo_pass=UserSudoPassword" # To work pass a Sudo password.
ansible-playbook main.yml -i inventory.yml --skip-tags update # Skip certain parts of he Process
```

### Available Tags

- `update` -> Updates all APT packages to Latest
- `lockdown` -> Lockdown Role
- `base` -> Base Install and Update Role