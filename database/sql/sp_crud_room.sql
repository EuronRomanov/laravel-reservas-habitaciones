-- CREAR HABITACIÓN
DELIMITER $$
CREATE PROCEDURE sp_create_room(
    IN p_name VARCHAR(255),
    IN p_description TEXT,
    IN p_price DECIMAL(10,2)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'ERROR' AS status, 'No se pudo crear la habitación' AS message;
        ROLLBACK;
    END;
    START TRANSACTION;
        INSERT INTO rooms (name, description, price, created_at, updated_at)
        VALUES (p_name, p_description, p_price, NOW(), NOW());
    COMMIT;
    SELECT 'OK' AS status, 'Habitación creada correctamente' AS message;
END$$
DELIMITER ;

-- ACTUALIZAR HABITACIÓN
DELIMITER $$
CREATE PROCEDURE sp_update_room(
    IN p_id BIGINT,
    IN p_name VARCHAR(255),
    IN p_description TEXT,
    IN p_price DECIMAL(10,2)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'ERROR' AS status, 'No se pudo actualizar la habitación' AS message;
        ROLLBACK;
    END;
    START TRANSACTION;
        UPDATE rooms 
        SET name = p_name, description = p_description, price = p_price, updated_at = NOW()
        WHERE id = p_id;
    COMMIT;
    SELECT 'OK' AS status, 'Habitación actualizada correctamente' AS message;
END$$
DELIMITER ;

-- ELIMINAR HABITACIÓN
DELIMITER $$
CREATE PROCEDURE sp_delete_room(IN p_id BIGINT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'ERROR' AS status, 'No se pudo eliminar la habitación' AS message;
        ROLLBACK;
    END;
    START TRANSACTION;
        DELETE FROM rooms WHERE id = p_id;
    COMMIT;
    SELECT 'OK' AS status, 'Habitación eliminada correctamente' AS message;
END$$
DELIMITER ;
