
DROP PROCEDURE IF EXISTS sp_delete_reservation;
CREATE PROCEDURE sp_delete_reservation(IN p_id BIGINT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'ERROR' AS status, 'No se pudo eliminar la reserva' AS message;
    END;

    START TRANSACTION;
        DELETE FROM reservations WHERE id = p_id;
    COMMIT;
    SELECT 'OK' AS status, 'Reserva eliminada correctamente' AS message;
END;