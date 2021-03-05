# MHN Ansible


Ansible Playbook to Provision the MHN Infrastructure

## Development

```shell
python3 -m pip install pipenv # Ensure Pipenv installed

pipenv install # Install Python packages into Venv

pipenv shell # Switch to Venv Shell

molecule converge # (Will Create a VM and Provision everythin against it.)
```