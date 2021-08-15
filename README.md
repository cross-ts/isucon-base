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
$ echo "NEW_RELIC_LICENSE_KEY=" > env.secret.sh
$ cp -r /etc/nginx/{nginx.conf,conf.d,sites-available} ~/git/isucon/nginx/
$ cp -r /etc/mysql/{mysql.cnf,conf.d,mysql.conf.d} ~/git/isucon/mysql/
$ cp -r /etc/systemd/system/<isucon service files> ~/git/isucon/systemd/
$ cp -r <path to webapp> ~/git/isucon/
$ cp ~/env.sh ~/git/isucon/
$ cd git && git cm -am 'checkin'
$ cd isucon/<path to ruby>
$ vim Gemfile
$ bundle
$ git cm -m 'bundle install'
$ git push
```

### あとは流れで
