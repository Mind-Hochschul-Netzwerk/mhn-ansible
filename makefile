workspace:
	echo Installing Ansible-Ansible Lint and so on into venv.
	PIPENV_VENV_IN_PROJECT=1 pipenv install
	ansible-galaxy install -r requirements.yml

bootstrap:
	ansible-playbook play_main.yml -i inventory.yml --skip-tags "startstack,backupcron"

updatestacks:
	ansible-playbook play_main.yml -i inventory.yml --skip-tags "update,backup,base"
all:
	ansible-playbook play_main.yml -i inventory.yml
