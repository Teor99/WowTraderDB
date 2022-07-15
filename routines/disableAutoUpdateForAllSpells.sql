CREATE
    DEFINER = root@localhost PROCEDURE disableAutoUpdateForAllSpells()
BEGIN
    UPDATE spell
    SET auto_update = FALSE;
END;
