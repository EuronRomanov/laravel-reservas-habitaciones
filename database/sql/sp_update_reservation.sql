DROP PROCEDURE IF EXISTS sp_update_reservation;
CREATE PROCEDURE sp_update_reservation(
    IN p_id BIGINT,
    IN p_check_in DATE,
    IN p_check_out DATE,
    IN p_status ENUM('pending','confirmed','cancelled')
)
BEGIN
    DECLARE v_room_id BIGINT;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'ERROR' AS status, 'No se pudo actualizar la reserva' AS message;
        ROLLBACK;
    END;

    SELECT room_id INTO v_room_id FROM reservations WHERE id = p_id;

    -- verificar solapamiento excluyendo la misma reserva
    IF EXISTS (
        SELECT 1 FROM reservations
        WHERE room_id = v_room_id
          AND id != p_id
          AND status != 'cancelled'
          AND (check_in < p_check_out AND check_out > p_check_in)
    ) THEN
        SELECT 'ERROR' AS status, 'Las fechas se solapan con otra reserva existente' AS message;
    ELSE
        START TRANSACTION;
            UPDATE reservations
            SET check_in = p_check_in,
                check_out = p_check_out,
                status = p_status,
                updated_at = NOW()
            WHERE id = p_id;
        COMMIT;
        SELECT 'OK' AS status, 'Reserva actualizada correctamente' AS message;
    END IF;
END;