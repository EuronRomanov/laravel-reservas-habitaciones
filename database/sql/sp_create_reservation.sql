
DROP PROCEDURE IF EXISTS sp_create_reservation;
CREATE PROCEDURE sp_create_reservation(
    IN p_room_id BIGINT,
    IN p_check_in DATE,
    IN p_check_out DATE,
    IN p_status ENUM('pending','confirmed','cancelled')
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'ERROR' AS status, 'No se pudo crear la reserva' AS message;
        ROLLBACK;
    END;

    -- verificar solapamiento
    IF EXISTS (
        SELECT 1 FROM reservations
        WHERE room_id = p_room_id
          AND status != 'cancelled'
          AND (check_in < p_check_out AND check_out > p_check_in)
    ) THEN
        SELECT 'ERROR' AS status, 'Ya existe una reserva que se solapa en estas fechas' AS message;
    ELSE
        START TRANSACTION;
            INSERT INTO reservations(room_id, check_in, check_out, status, created_at, updated_at)
            VALUES(p_room_id, p_check_in, p_check_out, p_status, NOW(), NOW());
        COMMIT;
        SELECT 'OK' AS status, 'Reserva creada correctamente' AS message;
    END IF;
END;