DROP PROCEDURE IF EXISTS sp_update_payment;
CREATE PROCEDURE sp_update_payment(
    IN p_id BIGINT,
    IN p_status ENUM('pending','authorized','captured','failed','refunded')
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'ERROR' AS status, 'No se pudo actualizar el pago' AS message;
    END;

    START TRANSACTION;
        UPDATE payments
        SET status = p_status,
            updated_at = NOW()
        WHERE id = p_id;
    COMMIT;
    SELECT 'OK' AS status, 'Pago actualizado correctamente' AS message;
END;
