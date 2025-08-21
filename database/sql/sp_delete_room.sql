DROP PROCEDURE IF EXISTS sp_delete_room;
CREATE PROCEDURE sp_delete_room(IN p_id BIGINT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'ERROR' AS status, 'No se pudo eliminar la habitación' AS message;
    END;

    START TRANSACTION;
        DELETE FROM rooms WHERE id = p_id;
    COMMIT;
    SELECT 'OK' AS status, 'Habitación eliminada correctamente' AS message;
END;