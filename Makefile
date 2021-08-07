COMMON_SERVER := isucon1

.PHONY: monitor
monitor:
	@ssh $(COMMON_SERVER) "sudo systemctl list-unit-files --type service" | tee monitor/list-unit-files.txt
	@ssh $(COMMON_SERVER) "ps auxf" | tee monitor/ps-aufx.txt
	@ssh $(COMMON_SERVER) "lscpu" | tee monitor/lscpu.txt

.PHONY: ansible
ansible:
	@ansible-playbook \
		-i ansible/inventory/host \
		ansible/playbook.yml

.PHONY: deploy
deploy:
	@ansible-playbook \
		-i deploy/inventory/host \
		deploy/playbook.yml
