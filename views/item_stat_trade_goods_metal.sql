DROP VIEW IF EXISTS item_stat_trade_goods_metal;

CREATE VIEW item_stat_trade_goods_metal AS
SELECT *
FROM item_stat_trade_goods
WHERE sc = 7
  AND name NOT LIKE '%камень%'
ORDER BY ch;