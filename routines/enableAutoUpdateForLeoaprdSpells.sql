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
