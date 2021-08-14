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
$ <アプリ名等を埋める>
$ make ansible
```
