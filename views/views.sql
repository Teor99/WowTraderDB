DROP VIEW IF EXISTS item_stat;

CREATE VIEW item_stat AS
WITH id_table AS (SELECT DISTINCT id
                  FROM item_cost
                  WHERE id NOT IN (SELECT id
                                   FROM item_cost
                                   WHERE source = 'vendor'))
SELECT id_table.id,
       i.name,
       class                                                        AS c,
       subclass                                                     AS sc,
       ic.source,
       price / 10000                                                AS price,
       getMedianPriceForLastDays(id_table.id, 14) / 10000           AS m,
       (price - getMedianPriceForLastDays(id_table.id, 14)) / 10000 AS diff,
       ROUND((price - getMedianPriceForLastDays(id_table.id, 14)) /
             getMedianPriceForLastDays(id_table.id, 14) * 100,
             2)                                                     AS ch,
       count,
       NULLIF((price - min_buyout) / 10000, 0)                      AS sdiff
FROM id_table
         JOIN item i ON id_table.id = i.item_id
         JOIN world.item_template wit ON id_table.id = wit.entry
         JOIN item_cost ic ON id_table.id = ic.id
         LEFT JOIN item_group ig ON id_table.id = ig.id
         LEFT JOIN item_for_sale ifs ON i.item_id = ifs.item_id AND ic.source = ifs.source;

#

DROP VIEW IF EXISTS item_stat_trade_goods;

CREATE VIEW item_stat_trade_goods AS
SELECT *
FROM item_stat
WHERE c = 7
ORDER BY ch;

#

DROP VIEW IF EXISTS item_stat_trade_goods_metal;

CREATE VIEW item_stat_trade_goods_metal AS
SELECT *
FROM item_stat_trade_goods
WHERE sc = 7
  AND name NOT LIKE '%камень%'
ORDER BY ch;

#

DROP VIEW IF EXISTS item_stat_trade_goods_metal_cooper;

CREATE VIEW item_stat_trade_goods_metal_cooper AS
SELECT istgm.*,
       ROUND((price / ig.multiplier), 4) AS pf1
FROM item_stat_trade_goods_metal istgm
         JOIN item_group ig ON istgm.id = ig.id
WHERE ig.name = 'cooper'
ORDER BY pf1;

#

DROP VIEW IF EXISTS item_stat_trade_goods_metal_silver;

CREATE VIEW item_stat_trade_goods_metal_silver AS
SELECT istgm.*,
       ROUND((price / ig.multiplier), 4) AS pf1
FROM item_stat_trade_goods_metal istgm
         JOIN item_group ig ON istgm.id = ig.id
WHERE ig.name = 'silver'
ORDER BY pf1;

#

DROP VIEW IF EXISTS item_stat_trade_goods_metal_steel;

CREATE VIEW item_stat_trade_goods_metal_steel AS
SELECT istgm.*,
       ROUND((price / ig.multiplier), 4) AS pf1
FROM item_stat_trade_goods_metal istgm
         JOIN item_group ig ON istgm.id = ig.id
WHERE ig.name = 'steel'
ORDER BY pf1;

#

DROP VIEW IF EXISTS item_stat_trade_goods_metal_gold;

CREATE VIEW item_stat_trade_goods_metal_gold AS
SELECT istgm.*,
       ROUND((price / ig.multiplier), 4) AS pf1
FROM item_stat_trade_goods_metal istgm
         JOIN item_group ig ON istgm.id = ig.id
WHERE ig.name = 'gold'
ORDER BY pf1;

#

DROP VIEW IF EXISTS item_stat_trade_goods_metal_mithril;

CREATE VIEW item_stat_trade_goods_metal_mithril AS
SELECT istgm.*,
       ROUND((price / ig.multiplier), 4) AS pf1
FROM item_stat_trade_goods_metal istgm
         JOIN item_group ig ON istgm.id = ig.id
WHERE ig.name = 'mithril'
ORDER BY pf1;

#

DROP VIEW IF EXISTS item_stat_trade_goods_metal_thorium;

CREATE VIEW item_stat_trade_goods_metal_thorium AS
SELECT istgm.*,
       ROUND((price / ig.multiplier), 4) AS pf1
FROM item_stat_trade_goods_metal istgm
         JOIN item_group ig ON istgm.id = ig.id
WHERE ig.name = 'thorium'
ORDER BY pf1;

#

DROP VIEW IF EXISTS item_stat_trade_goods_metal_fel_iron;

CREATE VIEW item_stat_trade_goods_metal_fel_iron AS
SELECT istgm.*,
       ROUND((price / ig.multiplier), 4) AS pf1
FROM item_stat_trade_goods_metal istgm
         JOIN item_group ig ON istgm.id = ig.id
WHERE ig.name = 'fel iron'
ORDER BY pf1;

#

DROP VIEW IF EXISTS item_stat_trade_goods_metal_adamantite;

CREATE VIEW item_stat_trade_goods_metal_adamantite AS
SELECT istgm.*,
       ROUND((price / ig.multiplier), 4) AS pf1
FROM item_stat_trade_goods_metal istgm
         JOIN item_group ig ON istgm.id = ig.id
WHERE ig.name = 'adamantite'
ORDER BY pf1;

#

DROP VIEW IF EXISTS item_stat_trade_goods_metal_elementium;

CREATE VIEW item_stat_trade_goods_metal_elementium AS
SELECT istgm.*,
       ROUND((price / ig.multiplier), 4) AS pf1
FROM item_stat_trade_goods_metal istgm
         JOIN item_group ig ON istgm.id = ig.id
WHERE ig.name = 'elementium'
ORDER BY pf1;

#

DROP VIEW IF EXISTS item_stat_trade_goods_metal_eternium;

CREATE VIEW item_stat_trade_goods_metal_eternium AS
SELECT istgm.*,
       ROUND((price / ig.multiplier), 4) AS pf1
FROM item_stat_trade_goods_metal istgm
         JOIN item_group ig ON istgm.id = ig.id
WHERE ig.name = 'eternium'
ORDER BY pf1;

#

DROP VIEW IF EXISTS item_stat_trade_goods_metal_cobalt;

CREATE VIEW item_stat_trade_goods_metal_cobalt AS
SELECT istgm.*,
       ROUND((price / ig.multiplier), 4) AS pf1
FROM item_stat_trade_goods_metal istgm
         JOIN item_group ig ON istgm.id = ig.id
WHERE ig.name = 'cobalt'
ORDER BY pf1;

#

DROP VIEW IF EXISTS item_stat_trade_goods_metal_khorium;

CREATE VIEW item_stat_trade_goods_metal_khorium AS
SELECT istgm.*,
       ROUND((price / ig.multiplier), 4) AS pf1
FROM item_stat_trade_goods_metal istgm
         JOIN item_group ig ON istgm.id = ig.id
WHERE ig.name = 'khorium'
ORDER BY pf1;

#

DROP VIEW IF EXISTS item_stat_trade_goods_metal_saronite;

CREATE VIEW item_stat_trade_goods_metal_saronite AS
SELECT istgm.*,
       ROUND((price / ig.multiplier), 4) AS pf1
FROM item_stat_trade_goods_metal istgm
         JOIN item_group ig ON istgm.id = ig.id
WHERE ig.name = 'saronite'
ORDER BY pf1;

#

DROP VIEW IF EXISTS item_stat_trade_goods_metal_titanium;

CREATE VIEW item_stat_trade_goods_metal_titanium AS
SELECT istgm.*,
       ROUND((price / ig.multiplier), 4) AS pf1
FROM item_stat_trade_goods_metal istgm
         JOIN item_group ig ON istgm.id = ig.id
WHERE ig.name = 'titanium'
ORDER BY pf1;

#

DROP VIEW IF EXISTS item_stat_trade_goods_stone;

CREATE VIEW item_stat_trade_goods_stone AS
SELECT *
FROM item_stat_trade_goods
WHERE sc = 7
  AND name LIKE '%камень%'
ORDER BY ch;

#

DROP VIEW IF EXISTS item_stat_trade_rods;

CREATE VIEW item_stat_trade_rods AS
SELECT *
FROM item_stat_trade_goods
WHERE sc = 12
  AND name LIKE '%жезл%'
ORDER BY ch;

#

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

#

DROP VIEW IF EXISTS profit_trade_goods_enchanting;

CREATE VIEW profit_trade_goods_enchanting AS
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
  AND subclass = 12
ORDER BY profit DESC;

#

DROP VIEW IF EXISTS profit_trade_goods_metal_stone;

CREATE VIEW profit_trade_goods_metal_stone AS
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
  AND subclass = 7
ORDER BY profit DESC;
