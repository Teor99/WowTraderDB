DROP PROCEDURE IF EXISTS disableAutoUpdateForAllSpells;

CREATE
    DEFINER = root@localhost PROCEDURE disableAutoUpdateForAllSpells()
BEGIN
    UPDATE spell
    SET auto_update = FALSE;
END;

#

DROP PROCEDURE IF EXISTS enableAutoUpdateForLeoaprdSpells;

CREATE
    DEFINER = root@localhost PROCEDURE enableAutoUpdateForLeoaprdSpells()
BEGIN
    UPDATE game_character gc
        JOIN game_character_spell_set gcss ON gc.char_id = gcss.char_id
        JOIN spell s ON gcss.spell_id = s.spell_id
        JOIN world.item_template wit ON s.craft_item_id = wit.entry
        JOIN item_class ic ON wit.class = ic.class
        JOIN item_subclass isc ON wit.class = isc.class AND wit.subclass = isc.subclass
    SET auto_update = TRUE
    WHERE gc.name = 'Leoaprd'
      AND ic.class NOT IN (2, 4);
END;

#

DROP FUNCTION IF EXISTS getMedianPriceForLastDays;

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