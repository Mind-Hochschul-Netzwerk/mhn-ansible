bootstrap:
	ansible-playbook main.yml -i inventory.yml --skip-tags "startstack,backupcron"

updatestacks:
	ansible-playbook main.yml -i inventory.yml --skip-tags "update,backup,base"

all:
	ansible-playbook main.yml -i inventory.yml

stacks:
	ansible-playbook main.yml -i inventory.yml --tags "dockerstacks"

backup:
	ansible-playbook main.yml -i inventory.yml --tags "backup"
