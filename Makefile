.PHONY: ansible
ansible:
	@ansible-playbook \
		-i ansible/inventory \
		ansible/playbook.yml
