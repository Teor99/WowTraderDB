DROP PROCEDURE IF EXISTS getMedianPriceForLastDays;

CREATE
    DEFINER = root@localhost FUNCTION getMedianPriceForLastDays(input_item_id INT, days INT) RETURNS INT DETERMINISTIC
BEGIN
    DECLARE result INT;

    SELECT ROUND(AVG(dd.val)) AS median_val
    INTO result
    FROM (SELECT d.val, @rownum := @rownum + 1 AS `row_number`, @total_rows := @rownum
          FROM (SELECT min_buyout AS val
                FROM item_history
                WHERE id = input_item_id
                  AND DATEDIFF(timestamp, NOW()) < days) AS d,
               (SELECT @rownum := 0) AS r
          WHERE d.val IS NOT NULL
          ORDER BY d.val) AS dd
    WHERE dd.row_number IN (FLOOR((@total_rows + 1) / 2), FLOOR((@total_rows + 2) / 2));

    RETURN result;
END;