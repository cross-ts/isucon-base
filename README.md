# 対ISUCON用リポジトリ

## 開始前対応
```
$ pbcopy < ~/.ssh/isucon_deploykey.pub
$ # deploy keyを登録
$ vim ansible/roles/git/vars/main.yml
```

## 初動
```
$ make monitor
$ vim ansible/roles/group_vars/all.yml
$ make ansible
```
