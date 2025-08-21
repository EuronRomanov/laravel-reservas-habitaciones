DROP PROCEDURE IF EXISTS sp_create_room;
CREATE PROCEDURE sp_create_room(
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
        SELECT 'ERROR' AS status, 'No se pudo crear la habitación' AS message;
    END;

    START TRANSACTION;
        INSERT INTO rooms ( name, description, capacity, base_price, status, created_at, updated_at)
        VALUES ( p_name, p_description, p_capacity, p_base_price, p_status, NOW(), NOW());
    COMMIT;
    SELECT 'OK' AS status, 'Habitación creada correctamente' AS message;
END;
