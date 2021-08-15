# 対ISUCON用リポジトリ

## 開始前対応
```
$ pbcopy < ~/.ssh/isucon_deploykey.pub
$ # deploy keyを登録
$ vim ansible/roles/git/vars/main.yml
```

## 初動
### 手元
```
$ make monitor
$ git cm -am 'make monitor' && git push
$ # monitor/results/list-unit-files.txt 確認
$ vim ansible/roles/group_vars/all.yml
$ make ansible
```

### ssh後
```
$ ssh isucon@isucon1
$ cp -r /etc/nginx/{nginx.conf,conf.d,sites-available} ~/git/isucon/nginx/
$ cp -r /etc/mysql/{mysql.cnf,conf.d,mysql.conf.d} ~/git/isucon/mysql/
$ cp -r /etc/systemd/system/<isucon service files> ~/git/isucon/systemd/
$ cp -r <path to webapp> ~/git/isucon/
$ git cm -m 'checkin'
```
