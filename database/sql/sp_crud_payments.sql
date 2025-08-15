DELIMITER $$
CREATE PROCEDURE sp_create_payment(
    IN p_reservation_id BIGINT,
    IN p_amount DECIMAL(10,2),
    IN p_method VARCHAR(50)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'ERROR' AS status, 'No se pudo registrar el pago' AS message;
        ROLLBACK;
    END;
    START TRANSACTION;
        INSERT INTO payments (reservation_id, amount, method, created_at, updated_at)
        VALUES (p_reservation_id, p_amount, p_method, NOW(), NOW());
    COMMIT;
    SELECT 'OK' AS status, 'Pago registrado correctamente' AS message;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_delete_payment(IN p_id BIGINT)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT 'ERROR' AS status, 'No se pudo eliminar el pago' AS message;
        ROLLBACK;
    END;
    START TRANSACTION;
        DELETE FROM payments WHERE id = p_id;
    COMMIT;
    SELECT 'OK' AS status, 'Pago eliminado correctamente' AS message;
END$$
DELIMITER ;
