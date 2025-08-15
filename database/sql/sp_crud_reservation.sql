DELIMITER $$
CREATE PROCEDURE sp_create_reservation(
    IN p_user_id BIGINT,
    IN p_room_id BIGINT,
    IN p_start_date DATE,
    IN p_end_date DATE
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'ERROR' AS status, 'No se pudo crear la reserva' AS message;
        ROLLBACK;
    END;
    START TRANSACTION;
        INSERT INTO reservations (user_id, room_id, start_date, end_date, created_at, updated_at)
        VALUES (p_user_id, p_room_id, p_start_date, p_end_date, NOW(), NOW());
    COMMIT;
    SELECT 'OK' AS status, 'Reserva creada correctamente' AS message;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_update_reservation(
    IN p_id BIGINT,
    IN p_start_date DATE,
    IN p_end_date DATE
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'ERROR' AS status, 'No se pudo actualizar la reserva' AS message;
        ROLLBACK;
    END;
    START TRANSACTION;
        UPDATE reservations
        SET start_date = p_start_date, end_date = p_end_date, updated_at = NOW()
        WHERE id = p_id;
    COMMIT;
    SELECT 'OK' AS status, 'Reserva actualizada correctamente' AS message;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_delete_reservation(IN p_id BIGINT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'ERROR' AS status, 'No se pudo eliminar la reserva' AS message;
        ROLLBACK;
    END;
    START TRANSACTION;
        DELETE FROM reservations WHERE id = p_id;
    COMMIT;
    SELECT 'OK' AS status, 'Reserva eliminada correctamente' AS message;
END$$
DELIMITER ;
