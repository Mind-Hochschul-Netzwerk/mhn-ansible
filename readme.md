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
make bootstrap # Refer to makefile for more make targets

## Custom Commands:
ansible-playbook main.yml -i inventory.yml --extra-vars "ansible_sudo_pass=UserSudoPassword" # Run playbook and pass sudo password
ansible-playbook main.yml -i inventory.yml --skip-tags "lockdown,startstack" # Run playbook skip certain parts of he Process
ansible-playbook main.yml -i inventory.yml --tags "apt-upgrade,backup" # Run certain parts of he Playbook
```

### Available Tags

Some parts of the process can be selected using [Ansible-Tags](https://docs.ansible.com/ansible/latest/user_guide/playbooks_tags.html).

| Tag            | Effect                                         |
| -------------- | ---------------------------------------------- |
| `base`         | Base Install and Update Role                   |
| `apt-upgrade`  | Updates all APT packages to Latest             |
| `lockdown`     | Lockdown Role (Lockdown Settings)              |
| `backup`       | Backup Role (Installs & configures Borgbackup) |
| `backupcron`   | Sets the cron task for backups                 |
| `startstack`   | Make or Docker-compose up commands             |
| `stackvolumes` | Stack volume Creation                          |
| `dockerstacks` | Only the Stack provisioning Play               |
| `users`        | User Creation                                  |

## Rrestore Process

To restore, please start with a fresh Ubuntu installation.
If your server got an initial account that is not root, please set a `initial_user` variable in the inventory. The user will be deleted and replaced with the users specified in the inventory.

```bash
pipenv shell #Activate the Python Envirionment with ansible in it.
make bootstrap # Runs ansible against the server and sets everything up. It wont start the Backupcon or the docker stacks yet.
```

SSH to the server using the `ansible_user`

Then you can retrieve the Backups using Borgmatic

```bash
sudo borgmatic extract --archive latest --verbosity 2 --destination /
```

Next it's time to restore the SQL Databases.
Start all the Docker stacks with `make database`

Then use the restore helper scrips to restore the databases

```
sudo restore-mysql "containername"
sudo restore-postgres "containername"
```

When done, run `make all` in your ansible environment to finish up the backup cron and start all the containers.
