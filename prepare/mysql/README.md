# MySQLのconfig周りのチューニング

## NOTE
- 8.0ではquery cacheが存在しないためselect過多なアプリでは注意
- サーバ単位での細かいチューニングポイントは書いてるから読んで

## OTHER
### クエリキャッシュのヒットレート計算
- ヒットレートが悪い場合はキャッシュを増やしてもオーバーヘッドが増える場合がある
- information_schema切ってると動かないかも
```
SELECT (SELECT VARIABLE_VALUE FROM INFORMATION_SCHEMA.GLOBAL_STATUS WHERE VARIABLE_NAME = 'QCACHE_HITS')/(SELECT SUM(VARIABLE_VALUE)
FROM INFORMATION_SCHEMA.GLOBAL_STATUS WHERE VARIABLE_NAME IN ('QCACHE_HITS','QCACHE_INSERTS','QCACHE_NOT_CACHED'))*100 AS CACHE_HIT_RATE;
```

### キャッシュから削除された割合
- これが低い場合はquery_cache_sizeを上げることを検討
```
(SELECT VARIABLE_VALUE FROM INFORMATION_SCHEMA.GLOBAL_STATUS WHERE VARIABLE_NAME = 'QCACHE_LOWMEM_PRUNES') /
(SELECT VARIABLE_VALUE FROM INFORMATION_SCHEMA.GLOBAL_STATUS WHERE VARIABLE_NAME = 'QCACHE_INSERTS') * 100;
```

### slowログ設定が当たってるかの確認
```
SHOW VARIABLES LIKE 'slow_query%';
```
