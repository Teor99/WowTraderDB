DROP VIEW IF EXISTS profit_trade_goods;

CREATE VIEW profit_trade_goods AS
SELECT id,
       i.name,
       action,
       a / 10000                                 AS a,
       getMedianPriceForLastDays(id, 14) / 10000 AS m,
       h / 10000                                 AS h,
       profit / 10000                            AS profit,
       comment
FROM item_profit_action ipa
         JOIN world.item_template wit ON ipa.id = wit.entry
         JOIN item i ON ipa.id = i.item_id
         JOIN spell s ON i.item_id = s.craft_item_id
WHERE auto_update = TRUE
  AND class = 7
ORDER BY profit DESC;