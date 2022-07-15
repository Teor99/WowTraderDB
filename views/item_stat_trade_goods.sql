DROP VIEW IF EXISTS item_stat_trade_goods;

CREATE VIEW item_stat_trade_goods AS
SELECT *
FROM item_stat
WHERE c = 7
ORDER BY ch;