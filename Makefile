WEB_SERVER := web
DB_SERVER := db

.PHONY: ansible
ansible:
	@ansible-playbook \
		-i ansible/inventory \
		ansible/playbook.yml

alp:
	@ssh $(WEB_SERVER) "alp -c /tmp/alp/config.yml ltsv" | tee monitor/alp.md
	@ssh $(WEB_SERVER) ": > sudo tee /var/log/nginx/access.log"

pt:
	@ssh $(DB_SERVER) "pt-query-digest /var/log/mysql/slow.log" | tee monitor/pt.txt
	@ssh $(WEB_SERVER) ": > sudo tee /var/log/mysql/slow.log"
