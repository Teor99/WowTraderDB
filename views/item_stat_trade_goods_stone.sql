DROP VIEW IF EXISTS item_stat_trade_goods_stone;

CREATE VIEW item_stat_trade_goods_stone AS
SELECT *
FROM item_stat_trade_goods
WHERE sc = 7
  AND name LIKE '%камень%'
ORDER BY ch;