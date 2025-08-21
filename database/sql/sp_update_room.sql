DROP PROCEDURE IF EXISTS sp_update_room;

CREATE PROCEDURE sp_update_room(
    IN p_id BIGINT,
    IN p_name VARCHAR(255),
    IN p_description TEXT,
    IN p_capacity INT,
    IN p_base_price DECIMAL(10,2),
    IN p_status ENUM('available','maintenance','unlisted')
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'ERROR' AS status, 'No se pudo actualizar la habitación' AS message;
    END;

    START TRANSACTION;
        UPDATE rooms
        SET name = p_name,
            description = p_description,
            capacity = p_capacity,
            base_price = p_base_price,
            status = p_status,
            updated_at = NOW()
        WHERE id = p_id;
    COMMIT;
    SELECT 'OK' AS status, 'Habitación actualizada correctamente' AS message;
END;