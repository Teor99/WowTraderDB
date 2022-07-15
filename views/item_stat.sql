DROP VIEW IF EXISTS item_stat;

CREATE VIEW item_stat AS
WITH id_table AS (SELECT DISTINCT id
                  FROM item_cost
                  WHERE id NOT IN (SELECT id
                                   FROM item_cost
                                   WHERE source = 'vendor'))
SELECT id_table.id,
       i.name,
       class AS c,
       subclass AS sc,
       source,
       price / 10000                                                AS price,
       getMedianPriceForLastDays(id_table.id, 14) / 10000           AS m,
       (price - getMedianPriceForLastDays(id_table.id, 14)) / 10000 AS diff,
       ROUND((price - getMedianPriceForLastDays(id_table.id, 14)) /
             getMedianPriceForLastDays(id_table.id, 14) * 100,
             2)                                                     AS ch
FROM id_table
         JOIN item i ON id_table.id = i.item_id
         JOIN world.item_template wit ON id_table.id = wit.entry
         JOIN item_cost ic ON id_table.id = ic.id;