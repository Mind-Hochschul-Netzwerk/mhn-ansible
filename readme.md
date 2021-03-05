# MHN Ansible


Ansible Playbook to Provision the MHN Infrastructure

## Development

```shell
python3 -m pip install pipenv # Ensure Pipenv installed

pipenv install # Install Python packages into Venv

pipenv shell # Switch to Venv shell

molecule converge # (Will Create a VM and provision everything against it)
```

# Local Port forwarding.

When you setup a wildcard DNS entry for localhost using for example `dnsmasq`, you can use [forwardports.sh](molecule/default/forwardports.sh).
To forward the VM HTTP/HTTPS Ports to localhost `80` and `443`.
