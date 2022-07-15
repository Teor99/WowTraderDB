DROP PROCEDURE IF EXISTS disableAutoUpdateForAllSpells;

CREATE
    DEFINER = root@localhost PROCEDURE disableAutoUpdateForAllSpells()
BEGIN
    UPDATE spell
    SET auto_update = FALSE;
END;
