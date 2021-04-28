bootstrap:
	ansible-playbook -i inventory.yml --skip-tags "startstack"

updatestacks:
	ansible-playbook -i inventory.yml --skip-tags "update,backup,base"
