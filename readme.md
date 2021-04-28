# MHN Ansible

[Ansible Playbook](https://docs.ansible.com/ansible/latest/user_guide/playbooks_intro.html) configure the MHN Infrastructure.

## Development

If you dont already have Ansible isntalled.
Python dependencies can be installed using [Pipenv](https://pypi.org/project/pipenv/).

For local testing, you can use [Vagrant](https://www.vagrantup.com/) with [Ansible-Molecule](https://molecule.readthedocs.io/en/latest/) to create a local VM and provision it.

```bash
# Prerequisites:
python3 -m pip install pipenv # Ensure Pipenv installed
pipenv install # Install Python packages into Venv
# Usage:
pipenv shell # Switch to Venv shell
molecule converge # Will Create a local VM and provision everything against it
```

### Ansible Role Requirements

It may be required to manually install the required ansible roles and collections:

```bash
ansible-galaxy install -r requirements.yml
```

### Local Port forwarding

When you setup a wildcard DNS entry for localhost using for example [dnsmasq](https://thekelleys.org.uk/dnsmasq/doc.html), you can use [forwardports.sh](molecule/default/forwardports.sh) to forward the VM HTTP/HTTPS ( `8080/8043` ) ports to localhost `80` and `443`.

## Deploy to remote machine

First make sure you have your `Inventory.yml` ready. See example: [inventory.sample.yml](inventory.sample.yml)

Here are some examples on how to run the playbook:

```bash
ansible-playbook main.yml -i inventory.yml --extra-vars "ansible_sudo_pass=UserSudoPassword" # Run playbook and pass sudo password
ansible-playbook main.yml -i inventory.yml --skip-tags "lockdown,startstack" # Run playbook skip certain parts of he Process
ansible-playbook main.yml -i inventory.yml --tags "update,backup" # Run certain parts of he Playbook
```

### Available Tags

Some parts of the process can be selected using [Ansible-Tags](https://docs.ansible.com/ansible/latest/user_guide/playbooks_tags.html).

| Tag            | Effect                                         |
| -------------- | ---------------------------------------------- |
| `base`         | Base Install and Update Role                   |
| `update`       | Updates all APT packages to Latest             |
| `lockdown`     | Lockdown Role (Lockdown Settings)              |
| `backup`       | Backup Role (Installs & configures Borgbackup) |
| `startstack`   | Make or Docker-compose up commands             |
| `stackvolumes` | Stack volume Creation                          |
| `dockerstacks` | Only the Stack provisioning Play               |
