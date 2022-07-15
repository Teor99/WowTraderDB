SELECT gc.name,
       s.*,
       ic.*,
       isc.*
FROM game_character gc
         JOIN game_character_spell_set gcss ON gc.char_id = gcss.char_id
         JOIN spell s ON gcss.spell_id = s.spell_id
         JOIN world.item_template wit ON s.craft_item_id = wit.entry
         JOIN item_class ic ON wit.class = ic.class
         JOIN item_subclass isc ON wit.class = isc.class AND wit.subclass = isc.subclass
WHERE gc.name = 'Leoaprd'
  AND ic.class NOT IN (2, 4)
# GROUP BY ic.class, subclass
ORDER BY ic.class, subclass;


INSERT INTO item_subclass
    (class, subclass, subclass_name)
VALUES (9, 11, 'Inscription'),
       (9, 12, 'Mining');

UPDATE game_character gc
    JOIN game_character_spell_set gcss ON gc.char_id = gcss.char_id
    JOIN spell s ON gcss.spell_id = s.spell_id
    JOIN world.item_template wit ON s.craft_item_id = wit.entry
    JOIN item_class ic ON wit.class = ic.class
    JOIN item_subclass isc ON wit.class = isc.class AND wit.subclass = isc.subclass
SET auto_update = TRUE
WHERE gc.name = 'Leoaprd'
  AND ic.class NOT IN (2, 4);

# GROUP BY ic.class, subclass
# ORDER BY ic.class, subclass;


SELECT min_buyout AS val
                FROM item_history
                WHERE id = 2840
                  AND DATEDIFF(timestamp, NOW()) < 10
                ORDER BY val DESC