WEB_SERVER := isucon
DB_SERVER := isucon

ISUCON := isuumo
LANGUAGE := ruby

##################################################
#   ___             _    _          _            #
#  | _ \_ _ _____ _(_)__(_)___ _ _ (_)_ _  __ _  #
#  |  _/ '_/ _ \ V / (_-< / _ \ ' \| | ' \/ _` | #
#  |_| |_| \___/\_/|_/__/_\___/_||_|_|_||_\__, | #
#                                         |___/  #
##################################################
.PHONY: init
init:
	@ssh $(WEB_SERVER) "sudo systemctl list-unit-files --type=service" | tee monitor/list-unit-files.txt
	@ssh $(WEB_SERVER) "ps auxf" | tee monitor/ps_auxf.txt

.PHONY: ansible
ansible:
	@ansible-playbook \
		-i ansible/inventories/inventory \
		ansible/playbook.yml

################################
#   ___         _ _            #
#  / __|___  __| (_)_ _  __ _  #
# | (__/ _ \/ _` | | ' \/ _` | #
#  \___\___/\__,_|_|_||_\__, | #
#                       |___/  #
################################
.PHONY: pull
pull:
	@ansible-playbook \
		-i ansible/inventories/init \
		ansible/playbook.yml

.PHONY: deploy
deploy:
	@ansible-playbook \
		-i ansible/inventories/deploy \
		ansible/playbook.yml

.PHONY: newrelic
newrelic:
	@echo tag to newrelic

.PHONY: bench
bench:
	@echo API叩いてbench回したい

###############################################
#  __  __          _ _           _            #
# |  \/  |___ _ _ (_) |_ ___ _ _(_)_ _  __ _  #
# | |\/| / _ \ ' \| |  _/ _ \ '_| | ' \/ _` | #
# |_|  |_\___/_||_|_|\__\___/_| |_|_||_\__, | #
#                                      |___/  #
###############################################
.PHONY: alp
alp:
	@ssh $(WEB_SERVER) "alp -c /tmp/alp/config.yml ltsv" | tee monitor/alp.md
	@ssh $(WEB_SERVER) ": | sudo tee /var/log/nginx/access.log"

.PHONY: pt
pt:
	@ssh $(DB_SERVER) "pt-query-digest /var/log/mysql/slow.log" | tee monitor/pt.txt
	@ssh $(DB_SERVER) ": | sudo tee /var/log/mysql/slow.log"

.PHONY: log
log:
	@ssh -t $(WEB_SERVER) "sudo journalctl -f -u $(ISUCON).$(LANGUAGE)"
