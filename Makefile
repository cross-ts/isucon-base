.PHONY: ansible
ansible:
	@ansible-playbook \
		-i ansible/inventory \
		ansible/playbook.yml

alp:
	@ssh <server> alp -c /tmp/alp/config.yml ltsv | tee monitor/alp.md
