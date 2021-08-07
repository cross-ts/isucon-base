COMMON_SERVER := isucon1

.PHONY: monitor
monitor:
	@ssh $(COMMON_SERVER) "sudo systemctl list-unit-files --type service" | tee monitor/results/list-unit-files.txt
	@ssh $(COMMON_SERVER) "ps auxf" | tee monitor/results/ps-aufx.txt
	@ssh $(COMMON_SERVER) "lscpu" | tee monitor/results/lscpu.txt

.PHONY: log
log:
	@ssh $(COMMON_SERVER) "sudo journalctl -f -u isuumo.ruby"

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
